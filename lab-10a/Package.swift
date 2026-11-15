// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "Lab10AUnitTests",
    platforms: [
        .iOS(.v16),
        .macOS(.v13)
    ],
    products: [
        .library(name: "UnitTestPracticeCore", targets: ["UnitTestPracticeCore"])
    ],
    targets: [
        .target(name: "UnitTestPracticeCore"),
        .testTarget(name: "UnitTestPracticeCoreTests", dependencies: ["UnitTestPracticeCore"])
    ]
)
