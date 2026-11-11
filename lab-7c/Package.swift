// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "Lab7CControls",
    platforms: [
        .iOS(.v16),
        .macOS(.v13)
    ],
    products: [
        .library(name: "ControlSummaryCore", targets: ["ControlSummaryCore"])
    ],
    targets: [
        .target(name: "ControlSummaryCore"),
        .testTarget(name: "ControlSummaryCoreTests", dependencies: ["ControlSummaryCore"])
    ]
)
