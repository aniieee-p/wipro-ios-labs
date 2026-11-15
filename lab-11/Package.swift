// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "Lab11ProfilingDemo",
    platforms: [
        .iOS(.v16),
        .macOS(.v13)
    ],
    products: [
        .library(name: "CourseSearchCore", targets: ["CourseSearchCore"])
    ],
    targets: [
        .target(name: "CourseSearchCore"),
        .testTarget(name: "CourseSearchCoreTests", dependencies: ["CourseSearchCore"])
    ]
)
