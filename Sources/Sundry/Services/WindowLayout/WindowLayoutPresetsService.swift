// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2026 The Sundry project

import AppKit
import ApplicationServices
import CoreGraphics

/// One window's position and size, captured for a preset. Matched back to a
/// live window on restore by bundle identifier and title; unmatched entries
/// (an app that quit, a window that closed) are silently skipped rather than
/// failing the whole restore.
struct WindowLayoutPresetWindow: Codable, Equatable {
    let bundleIdentifier: String?
    let appName: String
    let title: String
    let frame: CGRect
}

struct WindowLayoutPreset: Codable, Identifiable, Equatable {
    let id: UUID
    var name: String
    let windows: [WindowLayoutPresetWindow]
    let createdAt: Date

    init(id: UUID = UUID(), name: String, windows: [WindowLayoutPresetWindow],
        createdAt: Date = Date()) {
        self.id = id
        self.name = name
        self.windows = windows
        self.createdAt = createdAt
    }
}

/// Saves named window arrangements and restores every window in one to its
/// recorded position and size. Reuses no state from WindowLayoutService: this
/// is a one-shot batch write over plain Accessibility position/size
/// attributes, not a live-tracked feature, so it needs nothing running while
/// idle.
final class WindowLayoutPresetsService: ObservableObject {
    static let shared = WindowLayoutPresetsService()

    @Published private(set) var presets: [WindowLayoutPreset] = []

    private init() {
        presets = Self.load()
    }

    // MARK: - Persistence

    private static func load() -> [WindowLayoutPreset] {
        guard let data = UserDefaults.standard.data(forKey: DefaultsKey.windowLayoutPresetsData),
              let decoded = try? JSONDecoder().decode([WindowLayoutPreset].self, from: data)
        else { return [] }
        return decoded
    }

    private func save() {
        guard let data = try? JSONEncoder().encode(presets) else { return }
        UserDefaults.standard.set(data, forKey: DefaultsKey.windowLayoutPresetsData)
    }

    // MARK: - Capture

    /// Every regular, on-screen window right now, from the same public
    /// window-list API screenshots and Mission Control use — no Accessibility
    /// needed to capture, only to restore.
    func captureCurrentArrangement() -> [WindowLayoutPresetWindow] {
        guard let list = CGWindowListCopyWindowInfo(
            [.optionOnScreenOnly, .excludeDesktopElements], kCGNullWindowID) as? [[String: Any]]
        else { return [] }
        return list.compactMap { info -> WindowLayoutPresetWindow? in
            guard (info[kCGWindowLayer as String] as? Int) == 0,
                  let boundsDict = info[kCGWindowBounds as String] as? [String: CGFloat],
                  let pid = info[kCGWindowOwnerPID as String] as? Int32,
                  let ownerName = info[kCGWindowOwnerName as String] as? String,
                  boundsDict["Width"] ?? 0 > 40, boundsDict["Height"] ?? 0 > 40
            else { return nil }
            let frame = CGRect(x: boundsDict["X"] ?? 0, y: boundsDict["Y"] ?? 0,
                               width: boundsDict["Width"] ?? 0, height: boundsDict["Height"] ?? 0)
            let title = info[kCGWindowName as String] as? String ?? ""
            let bundleID = NSRunningApplication(processIdentifier: pid)?.bundleIdentifier
            return WindowLayoutPresetWindow(bundleIdentifier: bundleID, appName: ownerName,
                                            title: title, frame: frame)
        }
    }

    @discardableResult
    func savePreset(named name: String) -> WindowLayoutPreset {
        let preset = WindowLayoutPreset(name: name, windows: captureCurrentArrangement())
        presets.append(preset)
        save()
        return preset
    }

    func rename(_ preset: WindowLayoutPreset, to name: String) {
        guard let index = presets.firstIndex(where: { $0.id == preset.id }) else { return }
        presets[index].name = name
        save()
    }

    func delete(_ preset: WindowLayoutPreset) {
        presets.removeAll { $0.id == preset.id }
        save()
    }

    // MARK: - Restore

    /// Moves and resizes every live window that matches a saved entry.
    /// Returns how many of the preset's windows were actually found and
    /// moved, so the UI can say "restored 4 of 5" honestly rather than
    /// implying every window came back.
    @discardableResult
    func restore(_ preset: WindowLayoutPreset) -> Int {
        var restored = 0
        // Grouped by owning app so each app's AXUIElement tree — and its
        // current window list, consumed in encounter order below — is
        // fetched only once even when a preset has several of its windows.
        let byBundleID = Dictionary(grouping: preset.windows, by: { $0.bundleIdentifier })
        for (bundleID, entries) in byBundleID {
            guard let bundleID,
                  let app = NSRunningApplication.runningApplications(
                    withBundleIdentifier: bundleID).first
            else { continue }
            var liveWindows = axWindows(for: app.processIdentifier)
            for entry in entries {
                guard let matchIndex = liveWindows.firstIndex(where: { window in
                    (try? title(of: window)) == entry.title || entry.title.isEmpty
                }) else { continue }
                let window = liveWindows.remove(at: matchIndex)
                if setFrame(entry.frame, on: window) { restored += 1 }
            }
        }
        return restored
    }

    private func axWindows(for pid: pid_t) -> [AXUIElement] {
        let app = AXUIElementCreateApplication(pid)
        var value: CFTypeRef?
        guard AXUIElementCopyAttributeValue(app, kAXWindowsAttribute as CFString, &value)
                == .success,
              let windows = value as? [AXUIElement]
        else { return [] }
        return windows
    }

    private func title(of window: AXUIElement) throws -> String {
        var value: CFTypeRef?
        AXUIElementCopyAttributeValue(window, kAXTitleAttribute as CFString, &value)
        return (value as? String) ?? ""
    }

    private func setFrame(_ frame: CGRect, on window: AXUIElement) -> Bool {
        var origin = frame.origin
        var size = frame.size
        guard let positionValue = AXValueCreate(.cgPoint, &origin),
              let sizeValue = AXValueCreate(.cgSize, &size)
        else { return false }
        // Position first: some apps clamp size to fit the screen at the
        // window's CURRENT origin, so setting position first gives the size
        // write the destination screen's actual bounds to clamp against.
        let positioned = AXUIElementSetAttributeValue(window, kAXPositionAttribute as CFString,
                                                       positionValue) == .success
        let sized = AXUIElementSetAttributeValue(window, kAXSizeAttribute as CFString,
                                                  sizeValue) == .success
        return positioned || sized
    }
}
