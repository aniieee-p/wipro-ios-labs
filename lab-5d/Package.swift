// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "Lab5DCore",
    platforms: [
        .iOS(.v16),
        .macOS(.v13)
    ],
    products: [
        .library(name: "ConcurrencySafetyCore", targets: ["ConcurrencySafetyCore"])
    ],
    targets: [
        .target(name: "ConcurrencySafetyCore"),
        .testTarget(name: "ConcurrencySafetyCoreTests", dependencies: ["ConcurrencySafetyCore"])
    ]
)
