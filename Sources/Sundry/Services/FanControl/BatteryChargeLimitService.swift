// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2026 The Sundry project

import AppKit
import Combine

/// Stops charging at a percentage the user chooses, by polling the battery
/// and asking the privileged fan-control helper to write the SMC's charge
/// inhibit key (see BatteryChargeControl in FanControlHardware.swift). The
/// helper is a shared resource between this feature and Fan Control — see
/// FanControlService.syncWithPreferences.
///
/// EXPERIMENTAL: this writes to real battery-controller hardware. It is
/// off by default, gated behind an explicit confirmation in Settings, and
/// exercised here only through its restore-safety paths — never a live
/// inhibit toggle — so a build can be verified without touching any
/// particular Mac's battery. See NOTICE.md.
///
/// Mirrors BluetoothSleepService's shape: nothing runs while the feature is
/// off, and an "owed restore" flag survives an ungraceful quit so a Mac shut
/// down mid-inhibit still gets its charging back on the next launch.
final class BatteryChargeLimitService: ObservableObject {
    static let shared = BatteryChargeLimitService()

    /// nil until the helper has answered once; SettingsView shows the picker
    /// only once this is known, so it never dangles a control this Mac can't
    /// honor.
    @Published private(set) var isSupported: Bool?
    @Published private(set) var isCurrentlyInhibiting = false

    private var timer: Timer?
    private var wakeObserver: NSObjectProtocol?
    private var powerSourceObserver: NSObjectProtocol?
    private let pollInterval: TimeInterval = 60

    private init() {}

    func syncWithPreferences() {
        let defaults = UserDefaults.standard
        guard AppFeature.batteryChargeLimit.isAvailable,
              defaults.bool(forKey: DefaultsKey.batteryChargeLimitEnabled)
        else {
            stop()
            return
        }
        // The helper this feature needs is the same one Fan Control installs;
        // authorize() is idempotent when it is already registered and running.
        FanControlService.shared.authorize()
        installObservers()
        evaluate()
    }

    func stop() {
        timer?.invalidate()
        timer = nil
        if let wakeObserver { NSWorkspace.shared.notificationCenter.removeObserver(wakeObserver) }
        wakeObserver = nil
        if let powerSourceObserver { NotificationCenter.default.removeObserver(powerSourceObserver) }
        powerSourceObserver = nil
        // Releasing an inhibit the feature no longer wants is the one write
        // that must still happen after the feature itself is off.
        releaseIfInhibiting()
    }

    private func installObservers() {
        guard wakeObserver == nil else { return }
        wakeObserver = NSWorkspace.shared.notificationCenter.addObserver(
            forName: NSWorkspace.didWakeNotification,
            object: nil, queue: .main) { [weak self] _ in self?.evaluate() }
        powerSourceObserver = NotificationCenter.default.addObserver(
            forName: .NSSystemClockDidChange, object: nil, queue: .main) { [weak self] _ in
            self?.evaluate()
        }
        let timer = Timer(timeInterval: pollInterval, repeats: true) { [weak self] _ in self?.evaluate() }
        RunLoop.main.add(timer, forMode: .common)
        self.timer = timer
    }

    /// Reads the battery, decides whether charging should be inhibited right
    /// now, and asks the helper only when that decision changed — so a Mac
    /// already sitting below the limit is not re-asked every poll.
    private func evaluate() {
        let reading = PowerSampler(smc: SMCClient()).sample()
        guard reading.hasBattery, reading.externalConnected,
              let percent = reading.chargePercent else {
            releaseIfInhibiting()
            return
        }
        let limit = Defaults.sanitizedBatteryChargeLimitPercent(
            UserDefaults.standard.integer(forKey: DefaultsKey.batteryChargeLimitPercent))
        let shouldInhibit = percent >= limit
        guard shouldInhibit != isCurrentlyInhibiting else { return }
        setInhibited(shouldInhibit)
    }

    private func releaseIfInhibiting() {
        guard isCurrentlyInhibiting
            || UserDefaults.standard.bool(forKey: DefaultsKey.batteryChargeInhibitOwedRestore)
        else { return }
        setInhibited(false)
    }

    private func setInhibited(_ inhibited: Bool) {
        let defaults = UserDefaults.standard
        // Recorded before the round trip completes: if the app or the Mac
        // goes away mid-write, the NEXT launch still knows to release it,
        // rather than trusting a reply that may never arrive.
        if inhibited { defaults.set(true, forKey: DefaultsKey.batteryChargeInhibitOwedRestore) }
        FanControlService.shared.setChargeInhibited(inhibited) { [weak self] succeeded, supported in
            guard let self else { return }
            if let supported { self.isSupported = supported }
            guard succeeded else { return }
            self.isCurrentlyInhibiting = inhibited
            if !inhibited { defaults.set(false, forKey: DefaultsKey.batteryChargeInhibitOwedRestore) }
        }
    }
}
