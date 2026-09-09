// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2026 The Sundry project

import SwiftUI

/// Focus timer's settings section, embedded in Quick tools.
struct FocusTimerSection: View {
    @ObservedObject private var l10n = L10n.shared
    @ObservedObject private var timer = FocusTimerService.shared
    @AppStorage(DefaultsKey.focusTimerWorkMinutes) private var workMinutes = 25
    @AppStorage(DefaultsKey.focusTimerBreakMinutes) private var breakMinutes = 5
    @AppStorage(DefaultsKey.focusTimerAutoStartNext) private var autoStartNext = false

    private var text: FocusTimerStrings { FeatureStrings.focusTimer(l10n.language) }

    var body: some View {
        Section {
            statusRow
            HStack {
                Stepper(value: $workMinutes, in: 5...120, step: 5) {
                    Text(text.workLabel + ": \(workMinutes)m")
                }
                Stepper(value: $breakMinutes, in: 1...60, step: 1) {
                    Text(text.breakLabel + ": \(breakMinutes)m")
                }
            }
            Toggle(text.autoStartNext, isOn: $autoStartNext)
            Text(String(format: text.sessionsTodayFormat, timer.sessionsCompletedToday))
                .font(.caption)
                .foregroundStyle(.secondary)
            controls
        } header: {
            Text(text.pageTitle)
        }
    }

    @ViewBuilder
    private var statusRow: some View {
        switch timer.phase {
        case .idle:
            Text(text.idleLabel)
                .font(.caption)
                .foregroundStyle(.secondary)
        case .work:
            Text(String(format: text.statusWorkFormat, timeString))
                .font(.headline)
        case .onBreak:
            Text(String(format: text.statusBreakFormat, timeString))
                .font(.headline)
        }
    }

    private var timeString: String {
        let minutes = timer.remainingSeconds / 60
        let seconds = timer.remainingSeconds % 60
        return String(format: "%d:%02d", minutes, seconds)
    }

    @ViewBuilder
    private var controls: some View {
        HStack {
            switch (timer.phase, timer.isPaused) {
            case (.idle, _):
                Button(text.startButton) { FocusTimerService.shared.start() }
                    .buttonStyle(.borderedProminent)
            case (_, true):
                Button(text.resumeButton) { FocusTimerService.shared.resume() }
                    .buttonStyle(.borderedProminent)
                Button(text.resetButton) { FocusTimerService.shared.reset() }
            case (_, false):
                Button(text.pauseButton) { FocusTimerService.shared.pause() }
                Button(text.skipButton) { FocusTimerService.shared.skip() }
                Button(text.resetButton) { FocusTimerService.shared.reset() }
            }
        }
    }
}

/// Menu bar overflow's settings section, embedded in General.
struct MenuBarOverflowSection: View {
    @ObservedObject private var l10n = L10n.shared
    @ObservedObject private var service = MenuBarOverflowService.shared
    @AppStorage(DefaultsKey.menuBarOverflowEnabled) private var enabled = false
    @State private var itemIDs: [(id: String, title: String)] = []

    private var text: MenuBarOverflowStrings { FeatureStrings.menuBarOverflow(l10n.language) }

    var body: some View {
        Section {
            Toggle(text.enable, isOn: $enabled)
                .onChange(of: enabled) { _, _ in
                    MenuBarOverflowService.shared.syncWithPreferences()
                    refresh()
                }
            Text(text.caption)
                .font(.caption)
                .foregroundStyle(.secondary)
            if enabled {
                if itemIDs.isEmpty {
                    Text(text.dragHint)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                } else {
                    ForEach(itemIDs, id: \.id) { entry in
                        Toggle(entry.title, isOn: Binding(
                            get: { service.hiddenItemIDs.contains(entry.id) },
                            set: { hidden in service.setHidden(entry.id, hidden: hidden) }))
                    }
                }
            }
        } header: {
            Text(text.pageTitle)
        }
        .onAppear(perform: refresh)
    }

    private func refresh() {
        itemIDs = StatusItemController.current?.currentMetricItemIDs ?? []
    }
}
