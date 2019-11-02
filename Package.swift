// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "CodingKeyKit",
    products: [
        .library(name: "CodingKeyKit", targets: ["CodingKeyKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/wickwirew/Runtime.git", from: "2.0.0")
    ],
    targets: [
        .target(name: "CodingKeyKit", dependencies: ["Runtime"]),
        .testTarget(name: "CodingKeyKitTests", dependencies: ["CodingKeyKit"]),
    ]
)
