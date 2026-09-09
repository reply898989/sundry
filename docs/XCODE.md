# Building in Xcode

Upstream Vorssaint builds through `build.sh`, which calls `swiftc` three times and
then hand-assembles the `.app`. `Vorssaint.xcodeproj` reproduces that same output
from Xcode, so the app can be built, run and debugged with the normal Xcode tooling.

Open `Vorssaint.xcodeproj`, pick the **Vorssaint** scheme, and press Run.

From the command line:

```bash
xcodebuild -project Vorssaint.xcodeproj -scheme Vorssaint -configuration Debug build
```

## How the targets map onto build.sh

| build.sh step | Xcode target | Product |
| --- | --- | --- |
| `swiftc Sources/Vorssaint/**/*.swift` | `Vorssaint` (application) | `Vorssaint.app` |
| `swiftc … Sources/FanControlHelper/main.swift` | `FanControlHelper` (tool) | `com.vorssaint.utils.fan-control` |
| `swiftc -emit-library Sources/NowPlayingAdapter` | `NowPlayingAdapter` (dynamic library) | `libVorssaintNowPlaying.dylib` |

`FanControlHelper` compiles the same five shared files the script passes it
(`FanControlSupport`, `FanControlXPC`, `SMCClient`, `TemperatureSensorSelector`,
`FanControlHardware`) plus its own `main.swift`.

## Bundle assembly

The app target reproduces the staging block of `build.sh`:

- **Copy Files** phases place the helper in `Contents/Library/LaunchServices`, the
  adapter in `Contents/Frameworks`, and the launchd job in
  `Contents/Library/LaunchDaemons`.
- **Resources** copies `CHANGELOG.md`, `now-playing.pl`, `Gifs/`, `Images/` and the
  twelve `.lproj` folders as folder references, matching the script's `cp -R`.
- A **Generate icons and stamp bundle** script phase runs `Tools/MakeIcon.swift`
  (producing `AppIcon.icns`, `MenuBarIcon.png`, `MenuBarIcon@2x.png`, `BrandMark.png`),
  compiles `Resources/Brand/AppIcon.icon` with `actool` into `Assets.car`, writes
  `PkgInfo`, and stamps `VorssaintFanControlHelperVersion` — the SHA-256 of the
  helper and its plist that `FanControlService` verifies at runtime.

`Resources/Info.plist` and `Resources/Vorssaint.entitlements` are used directly, so
the bundle identifier, version, `LSUIElement` and the TCC usage strings are unchanged.

## Settings that matter

- `SWIFT_INCLUDE_PATHS` points at `Sources/VMStatisticsCompat` and
  `Sources/HIDEventSystem` — the two module maps the script passes as `-I`.
- `ENABLE_DEBUG_DYLIB = NO` and `ENABLE_PREVIEWS = NO`: without them Xcode splits the
  Debug build into `Vorssaint.debug.dylib` + `__preview.dylib`, which the single
  executable in `Contents/MacOS/Vorssaint` is not.
- `ENABLE_USER_SCRIPT_SANDBOXING = NO`, so the icon phase can run `MakeIcon.swift`.
- Signing is ad-hoc (`CODE_SIGN_IDENTITY = "-"`), the same fallback `build.sh` uses
  when no Developer ID is present. Release/notarised builds still go through `build.sh`.

## Verifying a build

```bash
Vorssaint.app/Contents/Library/LaunchServices/com.vorssaint.utils.fan-control --selftest
Vorssaint.app/Contents/MacOS/Vorssaint --selftest
codesign --verify --deep --strict Vorssaint.app
```
