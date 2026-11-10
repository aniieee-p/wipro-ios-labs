// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "AssessmentM2",
    platforms: [
        .iOS(.v16),
        .macOS(.v13)
    ],
    products: [
        .library(name: "MilestoneCore", targets: ["MilestoneCore"])
    ],
    targets: [
        .target(name: "MilestoneCore"),
        .testTarget(name: "MilestoneCoreTests", dependencies: ["MilestoneCore"])
    ]
)
