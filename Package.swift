// swift-tools-version:6.0
import PackageDescription

let package = Package(
    name: "tap-guard",
    platforms: [
        .macOS(.v10_15),
    ],
    products: [
        .library(
            name: "TapGuard",
            targets: ["TapGuard"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/Akazm/allocated-unfair-lock", .upToNextMajor(from: "1.2.0")),
        .package(url: "https://github.com/nicklockwood/SwiftFormat", .upToNextMajor(from: "0.55.0")),
        .package(url: "https://github.com/apple/swift-async-algorithms", .upToNextMajor(from: "1.0.0")),
        .package(url: "https://github.com/sideeffect-io/AsyncExtensions", .upToNextMajor(from: "0.5.3")),
        .package(url: "https://github.com/apple/swift-atomics.git", .upToNextMajor(from: "1.2.0")),
        .package(url: "https://github.com/pointfreeco/swift-concurrency-extras", .upToNextMajor(from: "1.3.0"))
    ],
    targets: [
        .target(
            name: "TapGuard",
            dependencies: [
                "AsyncExtensions",
                .product(name: "AllocatedUnfairLockShim", package: "allocated-unfair-lock"),
                .product(name: "AsyncAlgorithms", package: "swift-async-algorithms"),
                .product(name: "ConcurrencyExtras", package: "swift-concurrency-extras"),
                .product(name: "Atomics", package: "swift-atomics")
            ],
            path: "Sources/TapGuard"
        ),
        .testTarget(
            name: "TapGuardTests",
            dependencies: [
                "TapGuard",
                "AsyncExtensions",
                .product(name: "AllocatedUnfairLockShim", package: "allocated-unfair-lock"),
                .product(name: "Atomics", package: "swift-atomics")
            ],
            path: "Sources/Tests"
        )
    ]
)