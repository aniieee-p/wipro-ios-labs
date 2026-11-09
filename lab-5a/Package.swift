// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "QueueDemoCore",
    platforms: [
        .iOS(.v16),
        .macOS(.v13)
    ],
    products: [
        .library(name: "QueueDemoCore", targets: ["QueueDemoCore"])
    ],
    targets: [
        .target(name: "QueueDemoCore"),
        .testTarget(name: "QueueDemoCoreTests", dependencies: ["QueueDemoCore"])
    ]
)
