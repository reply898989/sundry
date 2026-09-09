// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2026 The Sundry project

import SwiftUI

/// Window pin's settings section, embedded in WindowLayoutSettings.
struct WindowPinSection: View {
    @ObservedObject private var l10n = L10n.shared
    @ObservedObject private var service = WindowPinService.shared
    @AppStorage(DefaultsKey.windowPinEnabled) private var enabled = true

    private var text: WindowPinStrings { FeatureStrings.windowPin(l10n.language) }

    var body: some View {
        Section(text.pageTitle) {
            Toggle(text.enable, isOn: $enabled)
                .onChange(of: enabled) { _, _ in WindowPinService.shared.syncWithPreferences() }
            Text(text.caption)
                .font(.caption)
                .foregroundStyle(.secondary)
            if enabled {
                Button(text.shortcutLabel) {
                    WindowPinService.shared.togglePinFrontmost()
                }
                if !service.pinned.isEmpty {
                    ForEach(service.pinned) { window in
                        HStack {
                            Image(systemName: "pin.fill")
                                .foregroundStyle(.orange)
                                .font(.caption)
                            VStack(alignment: .leading, spacing: 1) {
                                Text(window.appName)
                                if !window.title.isEmpty {
                                    Text(window.title)
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                        .lineLimit(1)
                                }
                            }
                            Spacer()
                            Button(text.unpinMenuItem) { service.unpin(window) }
                                .buttonStyle(.borderless)
                        }
                    }
                }
            }
        }
    }
}

/// Window layout presets' settings section, embedded in WindowLayoutSettings.
struct WindowLayoutPresetsSection: View {
    @ObservedObject private var l10n = L10n.shared
    @ObservedObject private var service = WindowLayoutPresetsService.shared
    @State private var newPresetName = ""
    @State private var toast: String?
    @State private var pendingDelete: WindowLayoutPreset?
    @State private var renaming: WindowLayoutPreset?
    @State private var renameText = ""

    private var text: WindowLayoutPresetsStrings { FeatureStrings.windowLayoutPresets(l10n.language) }

    var body: some View {
        Section(text.sectionTitle) {
            Text(text.caption)
                .font(.caption)
                .foregroundStyle(.secondary)
            HStack {
                TextField(text.saveNamePlaceholder, text: $newPresetName)
                Button(text.saveButton) {
                    let name = newPresetName.trimmingCharacters(in: .whitespacesAndNewlines)
                    guard !name.isEmpty else { return }
                    service.savePreset(named: name)
                    toast = String(format: text.savedToastFormat, name)
                    newPresetName = ""
                }
                .disabled(newPresetName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }
            if service.presets.isEmpty {
                Text(text.emptyMessage)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            } else {
                ForEach(service.presets) { preset in
                    HStack {
                        if renaming?.id == preset.id {
                            TextField(text.saveNamePlaceholder, text: $renameText)
                                .onSubmit { commitRename(preset) }
                            Button(l10n.s.uninstallerCancel) { renaming = nil }
                                .buttonStyle(.borderless)
                        } else {
                            VStack(alignment: .leading, spacing: 1) {
                                Text(preset.name)
                                Text(String(format: text.windowCountFormat, preset.windows.count))
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                        }
                        Spacer()
                        Button {
                            let restored = service.restore(preset)
                            toast = restored > 0
                                ? String(format: text.restoredToastFormat, preset.name) : nil
                        } label: {
                            Image(systemName: "arrow.uturn.backward.circle")
                        }
                        .buttonStyle(.borderless)
                        .help(text.restoreTooltip)
                        Button {
                            renaming = preset
                            renameText = preset.name
                        } label: {
                            Image(systemName: "pencil")
                        }
                        .buttonStyle(.borderless)
                        .help(text.renameTooltip)
                        Button {
                            pendingDelete = preset
                        } label: {
                            Image(systemName: "trash")
                        }
                        .buttonStyle(.borderless)
                        .help(text.deleteTooltip)
                    }
                }
            }
            if let toast {
                Text(toast)
                    .font(.caption)
                    .foregroundStyle(.green)
            }
        }
        .alert(text.deleteConfirmTitle, isPresented: Binding(
            get: { pendingDelete != nil }, set: { if !$0 { pendingDelete = nil } })) {
            Button(text.cancelButton, role: .cancel) {}
            Button(text.deleteConfirmButton, role: .destructive) {
                if let pendingDelete { service.delete(pendingDelete) }
                pendingDelete = nil
            }
        } message: {
            Text(text.deleteConfirmMessage)
        }
    }

    private func commitRename(_ preset: WindowLayoutPreset) {
        let name = renameText.trimmingCharacters(in: .whitespacesAndNewlines)
        if !name.isEmpty { service.rename(preset, to: name) }
        renaming = nil
    }
}
