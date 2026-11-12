// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "Lab8ACourseExplorer",
    platforms: [
        .iOS(.v16),
        .macOS(.v13)
    ],
    products: [
        .library(name: "CourseExplorerCore", targets: ["CourseExplorerCore"])
    ],
    targets: [
        .target(name: "CourseExplorerCore"),
        .testTarget(name: "CourseExplorerCoreTests", dependencies: ["CourseExplorerCore"])
    ]
)
