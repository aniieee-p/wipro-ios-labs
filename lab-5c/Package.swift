// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "Lab5CCore",
    platforms: [
        .iOS(.v16),
        .macOS(.v13)
    ],
    products: [
        .library(name: "CourseDetailsCore", targets: ["CourseDetailsCore"])
    ],
    targets: [
        .target(name: "CourseDetailsCore"),
        .testTarget(name: "CourseDetailsCoreTests", dependencies: ["CourseDetailsCore"])
    ]
)
