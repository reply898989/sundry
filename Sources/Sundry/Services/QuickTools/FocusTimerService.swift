// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2026 The Sundry project

import Foundation

enum FocusTimerPhase: Equatable {
    case idle
    case work
    case onBreak

    /// Which phase follows this one when a session completes. `idle` has no
    /// natural successor; callers start explicitly with `.work`.
    var next: FocusTimerPhase {
        switch self {
        case .idle: return .work
        case .work: return .onBreak
        case .onBreak: return .work
        }
    }
}

/// A work/break countdown, entirely local: no server, no account, nothing
/// running while idle. Ticks once a second only while a phase is actively
/// counting down, and posts a local notification at each transition through
/// Notifier — the same one-shot helper WhatsApp organization and cleanup
/// summaries use.
final class FocusTimerService: ObservableObject {
    static let shared = FocusTimerService()

    @Published private(set) var phase: FocusTimerPhase = .idle
    @Published private(set) var remainingSeconds: Int = 0
    @Published private(set) var isPaused = false
    @Published private(set) var sessionsCompletedToday = 0

    private var timer: Timer?
    private var lastCompletionDay: Int?

    private init() {}

    func syncWithPreferences() {
        guard AppFeature.focusTimer.isAvailable else {
            stopAndReset()
            return
        }
        Notifier.requestPermission()
    }

    // MARK: - Controls

    func start() {
        guard AppFeature.focusTimer.isAvailable else { return }
        if phase == .idle { phase = .work }
        remainingSeconds = seconds(for: phase)
        isPaused = false
        runTimer()
    }

    func pause() {
        guard phase != .idle else { return }
        isPaused = true
        timer?.invalidate()
        timer = nil
    }

    func resume() {
        guard phase != .idle, isPaused else { return }
        isPaused = false
        runTimer()
    }

    /// Ends the current phase early and moves straight to the next one,
    /// counting a skipped work session the same as a completed one: the user
    /// chose to stop focusing, which is the signal the count exists to track.
    func skip() {
        guard phase != .idle else { return }
        advance()
    }

    func reset() {
        stopAndReset()
    }

    private func stopAndReset() {
        timer?.invalidate()
        timer = nil
        phase = .idle
        remainingSeconds = 0
        isPaused = false
    }

    // MARK: - Ticking

    private func runTimer() {
        timer?.invalidate()
        let timer = Timer(timeInterval: 1, repeats: true) { [weak self] _ in self?.tick() }
        RunLoop.main.add(timer, forMode: .common)
        self.timer = timer
    }

    private func tick() {
        guard remainingSeconds > 0 else {
            advance()
            return
        }
        remainingSeconds -= 1
    }

    private func advance() {
        let completedPhase = phase
        let strings = FeatureStrings.focusTimer(L10n.shared.language)
        if completedPhase == .work {
            recordCompletedSession()
            Notifier.post(title: strings.sessionCompleteTitle, body: strings.sessionCompleteBody)
        } else if completedPhase == .onBreak {
            Notifier.post(title: strings.breakCompleteTitle, body: strings.breakCompleteBody)
        }
        let next = completedPhase.next
        guard UserDefaults.standard.bool(forKey: DefaultsKey.focusTimerAutoStartNext) else {
            timer?.invalidate()
            timer = nil
            phase = next
            remainingSeconds = seconds(for: next)
            isPaused = true
            return
        }
        phase = next
        remainingSeconds = seconds(for: next)
    }

    private func recordCompletedSession() {
        let day = Calendar.current.ordinality(of: .day, in: .era, for: Date())
        if lastCompletionDay != day {
            sessionsCompletedToday = 0
            lastCompletionDay = day
        }
        sessionsCompletedToday += 1
    }

    private func seconds(for phase: FocusTimerPhase) -> Int {
        let defaults = UserDefaults.standard
        switch phase {
        case .idle: return 0
        case .work: return max(60, defaults.integer(forKey: DefaultsKey.focusTimerWorkMinutes) * 60)
        case .onBreak: return max(60, defaults.integer(forKey: DefaultsKey.focusTimerBreakMinutes) * 60)
        }
    }
}
