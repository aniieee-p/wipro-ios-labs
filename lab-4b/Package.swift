// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "Lab4B",
    platforms: [
        .iOS(.v16),
        .macOS(.v13)
    ],
    products: [
        .library(name: "LifecycleCore", targets: ["LifecycleCore"])
    ],
    targets: [
        .target(name: "LifecycleCore"),
        .testTarget(name: "LifecycleCoreTests", dependencies: ["LifecycleCore"])
    ]
)
