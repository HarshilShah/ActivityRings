// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "ActivityRings",
    platforms: [
        .iOS(.v8),
        .macOS(.v10_10),
        .tvOS(.v9),
        .watchOS(.v4)
    ],
    products: [
        .library(
            name: "ActivityRings",
            type: .dynamic,
            targets: ["ActivityRings"]),
    ],
    dependencies: [
        // no dependencies
    ],
    targets: [
        .target(
            name: "ActivityRings",
            dependencies: []),
        .testTarget(
            name: "ActivityRingsTests",
            dependencies: ["ActivityRings"]),
    ]
)
