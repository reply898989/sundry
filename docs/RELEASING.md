# Releasing

Sundry can be released two ways. Which one you get depends entirely on whether
an Apple **Developer ID** is configured, and the difference is visible to
everyone who downloads it — so this page spells out both.

## The short version

| | Unsigned (default today) | Signed |
| --- | --- | --- |
| Apple Developer account | not needed | required ($99/year) |
| Gatekeeper on first open | blocks; user must right-click → Open once | opens normally |
| Fan Control | **off** | on |
| Battery charge limit | **off** | on |
| In-app auto-update | sends the user to the releases page | installs in place |
| Release notes | say the build is not notarized | say it is |

Nothing is broken in the unsigned build. Those two features and the automatic
updater are switched off deliberately, because each one depends on verifying a
signature, and there is no certificate to verify against. See "Why" below.

## Cutting an unsigned release (no Apple account)

1. Add the version's entry to `CHANGELOG.md`. The workflow reads the notes out
   of it and **fails if the entry is missing or empty**, on purpose.
2. Tag and push:

   ```sh
   git tag v1.0.0 && git push origin v1.0.0
   ```

3. The `release` workflow builds, runs the self-tests, packages the DMG, and
   publishes it. It detects that no signing is configured, prints a warning,
   skips signing and notarization, and writes release notes that tell people
   the build is not notarized and how to open it anyway.

That is the whole flow. The DMG is ad-hoc signed, which is enough for macOS to
run it after the user approves it once.

## Turning signing on

You need an Apple Developer Program membership, a **Developer ID Application**
certificate, and an App Store Connect API key for notarization.

1. **Repository variable** — `SIGNING_TEAM_ID`, set to your 10-character Apple
   Team ID. The workflow keys off this: signing stays off until it is set.
2. **Repository secrets**, in the protected `release-signing` environment:
   - `SIGNING_CERT_P12` — base64 of your exported Developer ID `.p12`
   - `SIGNING_CERT_PASSWORD` — that export's password
   - `NOTARY_API_KEY_P8`, `NOTARY_KEY_ID`, `NOTARY_ISSUER_ID` — the
     notarization key
3. **Source constant** — set `teamID` in
   [`Sources/Sundry/Services/FanControl/FanControlXPC.swift`](../Sources/Sundry/Services/FanControl/FanControlXPC.swift)
   to the same Team ID. This is the one place it is written down, and both the
   XPC code requirements and the updater's signature check read it. It is a
   compiled-in constant rather than configuration because it is a security
   boundary: it must not be something the running app can be talked into
   changing.

With all three in place, the workflow signs, notarizes and staples, verifies
the result, and the two privileged features and the in-app updater come back on
by themselves.

## Why the features switch off

Fan Control and Battery charge limit both drive hardware through a
**root-privileged LaunchDaemon** over XPC. Both ends pin the other's code
signature so that only this app can talk to that helper. With no Developer ID
there is no certificate to pin, and the alternative — pinning only the bundle
identifier — is not a boundary at all, since any ad-hoc signed binary can claim
any identifier it likes. Rather than weaken a root interface, the requirement is
left unsatisfiable, the connection is refused, and Settings shows the
"helper unavailable" notice.

The self-updater is the same argument: it downloads an app and replaces the
running one with it. Doing that without being able to verify what was
downloaded is precisely the thing not to do, so an unsigned build opens the
releases page in the browser and lets the user decide.

Upstream hard-coded its own Team ID here. This fork must not inherit it —
[upstream's trademark terms](https://github.com/vorssaint/vorssaint-utils/blob/main/TRADEMARKS.md)
require a fork to use its own signing identity, and keeping theirs would have
meant this build trusting a helper, and accepting an update, signed by *them*.

## Local builds

`./build.sh` signs with a free self-signed identity when it can, falling back
to ad-hoc. That is enough for day-to-day development and keeps granted
permissions stable across rebuilds, but it is not a Developer ID and the
privileged features stay off there too.

For Xcode builds, see [XCODE.md](XCODE.md).
