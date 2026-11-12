// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "AssessmentM3",
    platforms: [
        .iOS(.v16),
        .macOS(.v13)
    ],
    products: [
        .library(name: "NetworkingUIKitCore", targets: ["NetworkingUIKitCore"])
    ],
    targets: [
        .target(name: "NetworkingUIKitCore"),
        .testTarget(name: "NetworkingUIKitCoreTests", dependencies: ["NetworkingUIKitCore"])
    ]
)
