// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "SubscriptionRestore",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
    ],
    products: [
        .library(name: "SubscriptionRestore", targets: ["SubscriptionRestore"]),
    ],
    targets: [
        .target(
            name: "SubscriptionRestore",
            path: "Sources/SubscriptionRestore",
            swiftSettings: [
                .swiftLanguageMode(.v5),
            ]
        ),
        .testTarget(
            name: "SubscriptionRestoreTests",
            dependencies: ["SubscriptionRestore"],
            path: "Tests/SubscriptionRestoreTests",
            swiftSettings: [
                .swiftLanguageMode(.v5),
            ]
        ),
    ]
)
