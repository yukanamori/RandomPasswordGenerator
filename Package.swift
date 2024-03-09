// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "RandomPasswordGenerator",
    products: [
        .library(
            name: "RandomPasswordGenerator",
            targets: ["RandomPasswordGenerator"]),
    ],
    targets: [
        .target(
            name: "RandomPasswordGenerator"),
        .testTarget(
            name: "RandomPasswordGeneratorTests",
            dependencies: ["RandomPasswordGenerator"]),
    ]
)
