// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2026 The Sundry project

import AppKit

/// Tucks Sundry's own menu bar metric items (CPU, memory, network and the
/// rest — see StatusItemController.metricStatusItems) behind a chevron item
/// this service owns. Deliberately narrow in scope: it only ever touches
/// items Sundry itself created, never another app's, so it needs none of the
/// private window-server APIs a Bartender-style "hide any app's icon" tool
/// relies on. See NOTICE.md.
final class MenuBarOverflowService: ObservableObject {
    static let shared = MenuBarOverflowService()

    @Published private(set) var isTemporarilyRevealed = false

    private var chevronItem: NSStatusItem?

    private init() {}

    var hiddenItemIDs: Set<String> {
        Set(UserDefaults.standard.stringArray(forKey: DefaultsKey.menuBarOverflowHiddenItemIDs) ?? [])
    }

    func setHidden(_ id: String, hidden: Bool) {
        var ids = hiddenItemIDs
        if hidden { ids.insert(id) } else { ids.remove(id) }
        UserDefaults.standard.set(Array(ids), forKey: DefaultsKey.menuBarOverflowHiddenItemIDs)
        objectWillChange.send()
        StatusItemController.current?.applyMenuBarOverflowVisibility()
    }

    func syncWithPreferences() {
        guard AppFeature.menuBarOverflow.isAvailable,
              UserDefaults.standard.bool(forKey: DefaultsKey.menuBarOverflowEnabled)
        else {
            removeChevron()
            StatusItemController.current?.applyMenuBarOverflowVisibility()
            return
        }
        installChevron()
        StatusItemController.current?.applyMenuBarOverflowVisibility()
    }

    private func installChevron() {
        guard chevronItem == nil else { return }
        let item = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
        item.button?.image = NSImage(systemSymbolName: "chevron.left",
                                     accessibilityDescription:
                                        FeatureStrings.menuBarOverflow(L10n.shared.language).showTemporarily)
        item.button?.target = self
        item.button?.action = #selector(chevronClicked)
        chevronItem = item
    }

    private func removeChevron() {
        guard let chevronItem else { return }
        NSStatusBar.system.removeStatusItem(chevronItem)
        self.chevronItem = nil
        isTemporarilyRevealed = false
    }

    @objc private func chevronClicked() {
        isTemporarilyRevealed.toggle()
        chevronItem?.button?.image = NSImage(
            systemSymbolName: isTemporarilyRevealed ? "chevron.right" : "chevron.left",
            accessibilityDescription: nil)
        StatusItemController.current?.applyMenuBarOverflowVisibility()
    }
}
