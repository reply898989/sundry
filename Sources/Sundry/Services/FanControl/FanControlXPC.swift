// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2026 Vorssaint
// Modified 2026 by the Sundry project, a fork of vorssaint/vorssaint-utils.

import Foundation

enum FanControlIdentifiers {
    /// The Apple Developer Team ID this build is signed with, and the single
    /// place it is written down: the XPC code requirements below and the
    /// self-updater's signature check (UpdateInstallerSupport) both read it.
    ///
    /// Empty on purpose. Upstream hard-coded its own team here, which a fork
    /// must not inherit: their trademark terms require a fork to use its own
    /// signing identity, and keeping theirs would have meant this build only
    /// trusting a helper — and only accepting an update — signed by *them*.
    ///
    /// Leaving it empty makes both requirements unsatisfiable, which fails
    /// closed: the privileged helper refuses the connection (Settings shows
    /// the "helper unavailable" notice) and the self-updater declines to
    /// install rather than running something it cannot authenticate. Put your
    /// own Team ID here once you sign releases with a Developer ID, and both
    /// come back on. See docs/RELEASING.md.
    static let teamID = ""

    /// Whether this build can verify Developer ID signatures at all: false in
    /// an unsigned or ad-hoc-signed build, where there is no certificate to
    /// pin and the privileged features stay off.
    static var hasDeveloperIDSigning: Bool { !teamID.isEmpty }

    #if SUNDRY_DEVELOPMENT
    static let appBundleID = "com.sundry.utils.dev"
    #else
    static let appBundleID = "com.sundry.utils"
    #endif

    static let helperID = "\(appBundleID).fan-control"
    static let plistName = "\(helperID).plist"

    static let appCodeRequirement = codeRequirement(pinning: appBundleID)
    static let helperCodeRequirement = codeRequirement(pinning: helperID)

    /// Deliberately still emits the certificate clause when `teamID` is
    /// empty, producing a requirement nothing can satisfy. Dropping the
    /// clause instead would leave a root-privileged listener pinned only to a
    /// bundle identifier, which any ad-hoc-signed binary can claim.
    private static func codeRequirement(pinning identifier: String) -> String {
        "anchor apple generic and certificate leaf[subject.OU] = \"\(teamID)\" "
            + "and identifier \"\(identifier)\""
    }
}

@objc protocol FanControlXPCProtocol {
    func status(withReply reply: @escaping (Data) -> Void)
    func startMaximumCooling(withReply reply: @escaping (Data) -> Void)
    func applyConfiguration(_ configuration: Data, withReply reply: @escaping (Data) -> Void)
    func heartbeat(withReply reply: @escaping (Data) -> Void)
    func restoreAutomatic(withReply reply: @escaping (Data) -> Void)
    /// Battery charge limit (issue: charge control needs the same root SMC
    /// access fan control already has, so it rides the same helper rather
    /// than standing up a second privileged process). Stateless and narrow:
    /// the app decides *when* to inhibit from its own unprivileged battery
    /// reading, and only ever asks the helper for this one on/off switch.
    func setChargeInhibited(_ inhibited: Bool, withReply reply: @escaping (Data) -> Void)
}

/// The charge-inhibit switch's result: whether the write succeeded and
/// whether this Mac exposes the SMC key at all, so the app can tell "failed"
/// from "not supported on this Mac" and stop retrying the latter.
struct ChargeInhibitResponse: Codable {
    let succeeded: Bool
    let supported: Bool
}

enum ChargeInhibitIPC {
    static func encode(_ response: ChargeInhibitResponse) -> Data {
        (try? JSONEncoder().encode(response))
            ?? Data(#"{"succeeded":false,"supported":false}"#.utf8)
    }

    static func decode(_ data: Data) -> ChargeInhibitResponse? {
        try? JSONDecoder().decode(ChargeInhibitResponse.self, from: data)
    }
}

enum FanControlIPC {
    static func encode(_ response: FanControlResponse) -> Data {
        // Every value in this closed response model is JSON encodable. Keeping
        // one deterministic fallback avoids ever violating the XPC reply shape.
        (try? JSONEncoder().encode(response))
            ?? Data(#"{"succeeded":false,"snapshot":{"fans":[],"isCooling":false},"error":"controlFailed"}"#.utf8)
    }

    static func decode(_ data: Data) -> FanControlResponse? {
        try? JSONDecoder().decode(FanControlResponse.self, from: data)
    }

    static func encode(_ configuration: FanControlConfiguration) -> Data? {
        try? JSONEncoder().encode(configuration)
    }

    static func decodeConfiguration(_ data: Data) -> FanControlConfiguration? {
        guard let configuration = try? JSONDecoder().decode(FanControlConfiguration.self,
                                                              from: data),
              FanControlPolicy.validConfiguration(configuration) else { return nil }
        return configuration
    }
}
