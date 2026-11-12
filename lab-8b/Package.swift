// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "Lab8BNavigation",
    platforms: [
        .iOS(.v16),
        .macOS(.v13)
    ],
    products: [
        .library(name: "CourseNavigationCore", targets: ["CourseNavigationCore"])
    ],
    targets: [
        .target(name: "CourseNavigationCore"),
        .testTarget(name: "CourseNavigationCoreTests", dependencies: ["CourseNavigationCore"])
    ]
)
