// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "Lab7BNavigation",
    platforms: [
        .iOS(.v16),
        .macOS(.v13)
    ],
    products: [
        .library(name: "CourseDirectoryCore", targets: ["CourseDirectoryCore"])
    ],
    targets: [
        .target(name: "CourseDirectoryCore"),
        .testTarget(name: "CourseDirectoryCoreTests", dependencies: ["CourseDirectoryCore"])
    ]
)
