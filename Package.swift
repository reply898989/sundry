// swift-tools-version:5.9
// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2026 Vorssaint
// Modified 2026 by the Sundry project, a fork of vorssaint/vorssaint-utils.

import PackageDescription

let package = Package(
    name: "Sundry",
    platforms: [.macOS(.v14)],
    targets: [
        .systemLibrary(
            name: "HIDEventSystem",
            path: "Sources/HIDEventSystem"
        ),
        .systemLibrary(
            name: "VMStatisticsCompat",
            path: "Sources/VMStatisticsCompat"
        ),
        .executableTarget(
            name: "Sundry",
            dependencies: ["VMStatisticsCompat", "HIDEventSystem"],
            path: "Sources/Sundry"
        )
    ]
)
