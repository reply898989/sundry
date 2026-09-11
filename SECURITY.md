# Security Policy

Thanks for helping keep Sundry and the people who use it safe.

## Which project is affected

Sundry is a fork of [Vorssaint](https://github.com/vorssaint/vorssaint-utils),
and the overwhelming majority of this code is upstream's (see
[NOTICE.md](NOTICE.md)). That matters for disclosure:

- If the issue is in code Sundry inherited — most of the app — it almost
  certainly affects Vorssaint too, and **upstream should hear about it as
  well**, privately, through
  [their security policy](https://github.com/vorssaint/vorssaint-utils/security).
  Please do not delay telling them on this fork's account.
- If the issue is in something this fork added or changed (the six added
  features, the signing and update changes, the rebrand), it is ours alone and
  this is the right place.

If you are not sure which it is, report it here and say so; sorting that out
is our job, not yours.

## Reporting a vulnerability

Please report security vulnerabilities in private. Do not open a public issue, pull request or discussion for them.

Use GitHub's private vulnerability reporting for this repository.

- **[Report a vulnerability privately](https://github.com/reply898989/sundry/security/advisories/new)**

That opens a private security advisory that only you and the maintainer can see.

<!--
TODO for the maintainer. If you would like to offer a dedicated security contact
email alongside GitHub private advisories, add it here. No private email address
is published in this repository today, so the link above is the canonical route.
-->

When you write it up, please include as much as you can.

- A description of the issue and the impact it could have.
- Steps to reproduce, or a proof of concept.
- The Sundry version from Settings under About and your macOS version.

## What to expect

- This is a community project looked after on a best effort basis, so please allow reasonable time for a reply and a fix.
- Please give the maintainer a chance to ship a fix before you talk about the issue in public. That is what coordinated disclosure means.
- Credit goes gladly to reporters who want it.

## Supported versions

Security fixes land on the latest released version. Before you report, please make sure you can reproduce the issue on the most recent release.

## Scope

Sundry runs locally. Releases are currently **ad-hoc signed, not notarized**, because this fork has no Apple Developer ID — so please do not report "the app is not notarized" or the resulting Gatekeeper prompt as a vulnerability; it is a known and documented state, described in the README and in [docs/RELEASING.md](docs/RELEASING.md).

The reports that matter most are the ones that could affect the integrity of the app or its self update flow, or that could let the app's permissions be misused. Note that two privileged paths are deliberately disabled in an unsigned build (Fan Control and Battery charge limit, which reach a root helper over XPC, and automatic update installation), because without a certificate to pin there is nothing to verify against.

Issues in the outside services the app merely talks to, like GitHub's releases API or the speed test endpoint, are best taken to those providers.
