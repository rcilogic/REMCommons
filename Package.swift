// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "REMCommons",
    platforms: [
        .macOS(.v12)
    ],
    products: [
        .library(
            name: "REMCommons",
            targets: ["REMCommons"]),
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "4.0.0"),
        .package(url: "https://github.com/vapor/redis.git", from: "4.0.0")
    ],
    targets: [
        .target(
            name: "REMCommons",
            dependencies: [
                .product(name: "Vapor", package: "vapor"),
                .product(name: "Redis", package: "redis")
            ]),
        .testTarget(
            name: "REMCommonsTests",
            dependencies: ["REMCommons"]),
    ]
)
