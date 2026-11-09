// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "Lab5BCore",
    platforms: [
        .iOS(.v16),
        .macOS(.v13)
    ],
    products: [
        .library(name: "CourseLoadingCore", targets: ["CourseLoadingCore"])
    ],
    targets: [
        .target(name: "CourseLoadingCore"),
        .testTarget(name: "CourseLoadingCoreTests", dependencies: ["CourseLoadingCore"])
    ]
)
