// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2026 The Sundry project

import AppKit
import Combine

/// Switches the system between light and dark mode at two times of day,
/// through the same WindowServer switch QuickTogglesService's manual toggle
/// flips: instant, system wide, no Automation consent. Nothing exists while
/// the schedule is off: no timer, no observers, no cost. Mirrors
/// CleanerScheduler's shape (a pure calendar-math support enum plus a
/// stateful timer owner) so the two schedules read the same way.
final class DarkModeScheduleService: ObservableObject {
    static let shared = DarkModeScheduleService()

    /// When the next edge fires; Settings shows this line so arming the
    /// schedule gives visible confirmation on the spot.
    @Published private(set) var nextFire: Date?

    private var timer: Timer?
    private var wakeObserver: NSObjectProtocol?
    private var clockObservers: [NSObjectProtocol] = []

    private init() {}

    func syncWithPreferences() {
        guard AppFeature.darkModeSchedule.isAvailable,
              UserDefaults.standard.bool(forKey: DefaultsKey.darkModeScheduleEnabled)
        else {
            stop()
            return
        }
        installWakeObserver()
        applyCurrentEdge()
        scheduleNext()
    }

    func stop() {
        timer?.invalidate()
        timer = nil
        if let wakeObserver { NSWorkspace.shared.notificationCenter.removeObserver(wakeObserver) }
        wakeObserver = nil
        for observer in clockObservers { NotificationCenter.default.removeObserver(observer) }
        clockObservers = []
        if nextFire != nil { nextFire = nil }
    }

    private func installWakeObserver() {
        guard wakeObserver == nil else { return }
        wakeObserver = NSWorkspace.shared.notificationCenter.addObserver(
            forName: NSWorkspace.didWakeNotification,
            object: nil, queue: .main) { [weak self] _ in
            // An edge that passed during sleep never triggers its timer;
            // catching up (rather than waiting for tomorrow's edge) is the
            // whole point of a wake observer here.
            self?.applyCurrentEdge()
            self?.scheduleNext()
        }
        clockObservers = [NSNotification.Name.NSSystemTimeZoneDidChange,
                          NSNotification.Name.NSSystemClockDidChange].map { name in
            NotificationCenter.default.addObserver(forName: name, object: nil,
                                                   queue: .main) { [weak self] _ in
                self?.applyCurrentEdge()
                self?.scheduleNext()
            }
        }
    }

    private var minutes: (light: Int, dark: Int) {
        let defaults = UserDefaults.standard
        return (defaults.integer(forKey: DefaultsKey.darkModeScheduleLightMinutes),
                defaults.integer(forKey: DefaultsKey.darkModeScheduleDarkMinutes))
    }

    /// Sets the appearance to whichever side of the schedule "now" falls on.
    /// Called on enable and on every wake/clock change so a Mac that was
    /// asleep through an edge still lands on the right side immediately,
    /// rather than waiting for the next scheduled fire.
    private func applyCurrentEdge() {
        let current = minutes
        let dark = DarkModeSchedule.isDarkNow(Date(), lightMinutes: current.light, darkMinutes: current.dark)
        QuickTogglesService.shared.setDarkMode(dark)
    }

    private func scheduleNext() {
        let current = minutes
        guard let fireDate = DarkModeSchedule.nextFireDate(after: Date(),
                                                           lightMinutes: current.light,
                                                           darkMinutes: current.dark)
        else {
            nextFire = nil
            return
        }
        timer?.invalidate()
        let timer = Timer(fire: fireDate, interval: 0, repeats: false) { [weak self] _ in
            self?.applyCurrentEdge()
            self?.scheduleNext()
        }
        RunLoop.main.add(timer, forMode: .common)
        self.timer = timer
        nextFire = fireDate
    }
}
