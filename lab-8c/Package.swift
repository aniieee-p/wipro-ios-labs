// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "Lab8CStateManagement",
    platforms: [
        .iOS(.v16),
        .macOS(.v13)
    ],
    products: [
        .library(name: "CourseStateCore", targets: ["CourseStateCore"])
    ],
    targets: [
        .target(name: "CourseStateCore"),
        .testTarget(name: "CourseStateCoreTests", dependencies: ["CourseStateCore"])
    ]
)
