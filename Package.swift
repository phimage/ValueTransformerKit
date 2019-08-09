// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ValueTransformerKit",
    platforms: [
        .macOS(.v10_11),
        .iOS(.v9),
        .tvOS(.v9),
        .watchOS(.v3)
    ],
    products: [
        .library(
            name: "ValueTransformerKit",
            targets: ["ValueTransformerKit"])
    ],
    targets: [
        .target(
            name: "ValueTransformerKit",
            dependencies: [],
            path: "Sources"),
        .testTarget(
            name: "ValueTransformerKitTests",
            dependencies: ["ValueTransformerKit"],
            path: "Tests")
    ],
    swiftLanguageVersions: [.v5]
)
