// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2026 The Sundry project

import Foundation

/// When the automatic appearance switch fires. Pure calendar math, kept away
/// from the timer so tests can pin every boundary, matching CleanerSchedule.
enum DarkModeSchedule {
    /// The next moment the schedule should flip appearance strictly after
    /// `date`, given the two minute-of-day settings (0...1439, minutes since
    /// midnight). Light and dark can be set to the same minute, which
    /// disables the schedule's second edge without a separate off switch.
    static func nextFireDate(after date: Date,
                             lightMinutes: Int,
                             darkMinutes: Int,
                             calendar: Calendar = .current) -> Date? {
        guard lightMinutes != darkMinutes else { return nil }
        let candidates = [lightMinutes, darkMinutes].compactMap { minutes -> Date? in
            var components = DateComponents()
            components.hour = clampedMinutes(minutes) / 60
            components.minute = clampedMinutes(minutes) % 60
            return calendar.nextDate(after: date, matching: components, matchingPolicy: .nextTime)
        }
        return candidates.min()
    }

    /// Whether dark mode should be on right now, given the two edges. Used
    /// both to catch up after a missed fire (sleep, quit) and to preview the
    /// schedule in Settings without waiting for the next edge.
    static func isDarkNow(_ date: Date, lightMinutes: Int, darkMinutes: Int,
                          calendar: Calendar = .current) -> Bool {
        guard lightMinutes != darkMinutes else { return false }
        let components = calendar.dateComponents([.hour, .minute], from: date)
        let nowMinutes = (components.hour ?? 0) * 60 + (components.minute ?? 0)
        let light = clampedMinutes(lightMinutes), dark = clampedMinutes(darkMinutes)
        // Dark starts at `dark` and runs past midnight to `light`. Whether
        // that span wraps depends only on which edge is later in the day.
        if dark < light {
            return nowMinutes >= dark && nowMinutes < light
        } else {
            return nowMinutes >= dark || nowMinutes < light
        }
    }

    private static func clampedMinutes(_ minutes: Int) -> Int {
        min(max(minutes, 0), 24 * 60 - 1)
    }
}
