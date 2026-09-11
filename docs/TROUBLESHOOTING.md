# Troubleshooting

A quick guide to the snags people hit most. If none of it helps, jump to [reporting a useful bug](#reporting-a-useful-bug) at the end.

The permission and uninstall commands below all point at Sundry's bundle identifier, `com.sundry.utils`.

## The app will not open

**This is expected.** Sundry releases are ad-hoc signed, not notarized, because this fork has no Apple Developer ID — so macOS Gatekeeper stops the app on its first launch. It is not a sign that anything is wrong with the download. To open it, do one of these.

1. Right click, or Control click, Sundry in Applications, choose Open, and confirm.
2. Or open System Settings, Privacy and Security, find the note about Sundry being blocked, and click Open Anyway.
3. Or, from Terminal: `xattr -dr com.apple.quarantine /Applications/Sundry.app`

You only have to do this once per installed copy. [docs/RELEASING.md](RELEASING.md) explains the signing situation and what would change with a Developer ID.

Sundry lives in the menu bar, so once it starts, look for its icon up there rather than in the Dock.

## A feature does nothing, or a permission will not stick

Most features lean on a macOS permission, which the [permissions guide](PERMISSIONS.md) lays out. When something does nothing, walk through this.

1. Open System Settings, Privacy and Security.
2. Find the permission the feature needs and make sure Sundry is listed and switched on.
3. If it is listed and still quiet, toggle it off and back on.

Sundry keeps an eye on Accessibility and Screen Recording, so features tend to wake up within a second or two of a grant, with no relaunch needed.

### Accessibility

This one powers the scroll direction inverter, Window Layout, the switcher, Dock Preview, Finder cut and paste and quit on close. If they do nothing, open System Settings, Privacy and Security, Accessibility and confirm Sundry is switched on. If you rebuilt the app yourself, its signature can shift and macOS may treat it as a different app, so remove the old Sundry entry with the minus button and grant it again. For steady local signing while you develop, see the [contributing guide](../CONTRIBUTING.md).

### Screen Recording

This one feeds window titles and thumbnails in the switcher and Dock Preview. If previews fall back to app icons or Dock Preview stays unavailable, switch Sundry on in System Settings, Privacy and Security, Screen Recording. macOS may ask you to quit and reopen the app after you grant it.

### System Audio Recording

This one powers per app volume and output routing in the mixer. If the mixer says it needs permission, open System Settings, Privacy and Security, Screen and System Audio Recording, and switch Sundry on. Audio is processed only for the local mixer.

### Automation

Finder cut and paste, the uninstaller and Homebrew's Terminal handoff may ask for Automation. If a Finder move or Terminal handoff does nothing after a denial, open System Settings, Privacy and Security, Automation, and allow Sundry for the app it needs to control.

## Resetting permissions

To wipe Sundry's granted permissions and let macOS ask again from scratch, pick one of these.

- **From the app.** Settings under Advanced has a reset that clears every permission you granted, the login item and the closed lid rule, while leaving the app installed.
- **From Terminal.** Reset all of Sundry's privacy permissions at once.

  ```sh
  tccutil reset All com.sundry.utils
  ```

  Or reset a single kind, for example.

  ```sh
  tccutil reset Accessibility com.sundry.utils
  tccutil reset ScreenCapture com.sundry.utils
  ```

  A self-built Developer variant has its own grants under
  `com.sundry.utils.dev`. Resetting is the way out when System Settings
  shows the permission as granted but the app disagrees — that happens when a
  grant was given to an earlier ad-hoc build whose signature no longer matches.

## Clean uninstall

The bundled script takes out everything Sundry added, the app itself, its preferences and saved state, the login item, its privacy grants, and the optional closed lid `sudoers` rule.

```sh
./Tools/uninstall.sh
```

Run it from a clone of the repository, or download the single script from the repo. Would you rather do it by hand? Quit Sundry, drag it from Applications to the Trash, then clear its permissions.

```sh
tccutil reset All com.sundry.utils
```

## Reporting a useful bug

A clear report gets fixed faster. Try to include the following.

- **What you did**, what you expected, and what actually happened.
- **Your versions**, both the Sundry version from Settings under About and your macOS version.
- **Steps to reproduce**, as specific as you can make them.
- **A screenshot or short screen recording**, when the issue is something you can see.

If you have a build from source, the self test prints a quick health summary that is handy to paste in.

```sh
./build/Sundry --selftest
```

Open a report from the [new issue](https://github.com/reply898989/sundry/issues/new/choose) page, and see [support](../SUPPORT.md) for every way to get help.
