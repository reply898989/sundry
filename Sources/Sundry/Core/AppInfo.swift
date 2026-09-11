// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2026 Vorssaint
// Modified 2026 by the Sundry project, a fork of vorssaint/vorssaint-utils.

import Foundation

/// Static identity of the app, shared by UI, notifications and tooling.
enum AppInfo {
    static let name = "Sundry"
    static let copyright = "© 2026 Sundry · a GPL-3.0 fork of Vorssaint"
    static let repositoryURL = URL(string: "https://github.com/reply898989/sundry")!
    /// Where an unsigned build sends someone who asks it to update: it cannot
    /// verify a download, so the browser takes over. See UpdateService.
    static let releasesURL = URL(string: "https://github.com/reply898989/sundry/releases/latest")!

    /// Community and funding destinations. They stay `nil` until this fork owns
    /// the accounts behind them: every button that opens one is hidden while it
    /// is unset, so a build never sends anyone to somebody else's page.
    static let websiteURL: URL? = nil
    static let coffeeURL: URL? = nil
    static let discordURL: URL? = nil
    static let socialURL: URL? = nil

    /// The bundle version. The fallback only applies to the bare binary
    /// (e.g. `--selftest`), never the shipped app, which reads its Info.plist.
    static var version: String {
        Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "dev"
    }

    /// True for the local "Sundry (Developer)" build (bundle id ends in `.dev`).
    /// It is never published and never auto-updates; all work is tested here first.
    static var isDeveloperBuild: Bool {
        (Bundle.main.bundleIdentifier ?? "").hasSuffix(".dev")
    }

    /// True when the current version is a pre-release (e.g. 3.3.4-beta.1 or 3.3.4-rc.1).
    static var isBeta: Bool {
        if isDeveloperBuild && UserDefaults.standard.bool(forKey: DefaultsKey.simulateBetaUI) {
            return true
        }
        let v = version.lowercased()
        return v.contains("-beta") || v.contains("-rc") || v.contains("-alpha")
    }

    /// The git commit a Developer build was compiled from, e.g. "ed2ebba · 2026-06-15 21:30"
    /// (or with a "-dirty" suffix on the SHA for uncommitted changes). build.sh stamps
    /// this into the Developer bundle only, so you can confirm at a glance that the
    /// running dev app matches the source you are about to change. nil in the official app.
    static var buildCommit: String? {
        Bundle.main.object(forInfoDictionaryKey: "SundryBuildCommit") as? String
    }
}
