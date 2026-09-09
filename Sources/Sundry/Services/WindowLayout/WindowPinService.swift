// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2026 The Sundry project

import AppKit
import ApplicationServices

/// Keeps chosen windows above the others on their Space, using only public
/// Accessibility API. There is no public "set window level" call for a
/// window that belongs to another process — the private CGS calls some
/// third-party "always on top" tools use for that were deliberately avoided
/// here (see docs/XCODE.md and NOTICE.md on scope) — so a pinned window is
/// kept on top by re-raising it the moment anything else activates, rather
/// than by a true window-server z-order pin. In practice this is
/// indistinguishable during normal use; it will not out-rank a genuinely
/// full-screen app, and it only holds within the Space the window is on.
final class WindowPinService: ObservableObject {
    static let shared = WindowPinService()

    struct PinnedWindow: Identifiable {
        let id: CGWindowID
        let element: AXUIElement
        let pid: pid_t
        let title: String
        let appName: String
    }

    @Published private(set) var pinned: [PinnedWindow] = []

    private var activationObserver: NSObjectProtocol?
    private var terminationObserver: NSObjectProtocol?

    private init() {}

    func syncWithPreferences() {
        guard AppFeature.windowPin.isAvailable,
              UserDefaults.standard.bool(forKey: DefaultsKey.windowPinEnabled)
        else {
            unpinAll()
            removeObservers()
            return
        }
        installObservers()
    }

    var isPinned: Bool {
        guard let frontmost = frontmostWindow() else { return false }
        return pinned.contains { $0.id == frontmost.id }
    }

    /// Pins the frontmost window if nothing of its is pinned yet, otherwise
    /// unpins it. The one action both the panel button and (if wired) a
    /// shortcut call.
    func togglePinFrontmost() {
        guard let frontmost = frontmostWindow() else { return }
        if let index = pinned.firstIndex(where: { $0.id == frontmost.id }) {
            pinned.remove(at: index)
        } else {
            AXUIElementPerformAction(frontmost.element, kAXRaiseAction as CFString)
            pinned.append(frontmost)
        }
    }

    func unpin(_ window: PinnedWindow) {
        pinned.removeAll { $0.id == window.id }
    }

    private func unpinAll() {
        guard !pinned.isEmpty else { return }
        pinned.removeAll()
    }

    private func installObservers() {
        guard activationObserver == nil else { return }
        let center = NSWorkspace.shared.notificationCenter
        activationObserver = center.addObserver(
            forName: NSWorkspace.didActivateApplicationNotification,
            object: nil, queue: .main) { [weak self] notification in
            self?.reassertPins(exceptOwnedBy: notification)
        }
        terminationObserver = center.addObserver(
            forName: NSWorkspace.didTerminateApplicationNotification,
            object: nil, queue: .main) { [weak self] notification in
            guard let pid = (notification.userInfo?[NSWorkspace.applicationUserInfoKey]
                as? NSRunningApplication)?.processIdentifier else { return }
            self?.pinned.removeAll { $0.pid == pid }
        }
    }

    private func removeObservers() {
        let center = NSWorkspace.shared.notificationCenter
        if let activationObserver { center.removeObserver(activationObserver) }
        if let terminationObserver { center.removeObserver(terminationObserver) }
        activationObserver = nil
        terminationObserver = nil
    }

    /// Called every time any app activates: raises every pin that does not
    /// belong to the app that just came to front, so the newly active app's
    /// own windows are unaffected but everything pinned still floats above
    /// whatever else is now in front.
    private func reassertPins(exceptOwnedBy notification: Notification) {
        guard !pinned.isEmpty else { return }
        let activatedPID = (notification.userInfo?[NSWorkspace.applicationUserInfoKey]
            as? NSRunningApplication)?.processIdentifier
        for window in pinned where window.pid != activatedPID {
            AXUIElementPerformAction(window.element, kAXRaiseAction as CFString)
        }
    }

    private func frontmostWindow() -> PinnedWindow? {
        guard let app = NSWorkspace.shared.frontmostApplication else { return nil }
        let pid = app.processIdentifier
        let axApp = AXUIElementCreateApplication(pid)
        AXUIElementSetMessagingTimeout(axApp, 0.35)
        var value: CFTypeRef?
        guard AXUIElementCopyAttributeValue(axApp, kAXFocusedWindowAttribute as CFString, &value)
                == .success,
              let value, CFGetTypeID(value) == AXUIElementGetTypeID()
        else { return nil }
        // swiftlint:disable:next force_cast
        let element = value as! AXUIElement
        guard let windowID = AXWindowResolver.windowID(for: element) else { return nil }
        var titleValue: CFTypeRef?
        AXUIElementCopyAttributeValue(element, kAXTitleAttribute as CFString, &titleValue)
        return PinnedWindow(id: windowID, element: element, pid: pid,
                            title: (titleValue as? String) ?? "",
                            appName: app.localizedName ?? "")
    }
}
