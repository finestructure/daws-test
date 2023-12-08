// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "daws-test",
    platforms: [.macOS(.v13)],
    products: [
        .executable(name: "daws", targets: ["daws-test"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.3.0"),
        .package(url: "https://github.com/samalone/websocket-actor-system.git", from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .executableTarget(
            name: "daws-test",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "WebSocketActors", package: "websocket-actor-system")
            ]
        ),
        .testTarget(
            name: "daws-testTests",
            dependencies: ["daws-test"]),
    ]
)
