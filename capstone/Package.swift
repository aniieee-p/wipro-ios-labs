// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "CoursePlanner",
    platforms: [
        .iOS(.v16),
        .macOS(.v13)
    ],
    products: [
        .library(name: "CoursePlannerCore", targets: ["CoursePlannerCore"])
    ],
    targets: [
        .target(name: "CoursePlannerCore"),
        .testTarget(name: "CoursePlannerCoreTests", dependencies: ["CoursePlannerCore"])
    ]
)
