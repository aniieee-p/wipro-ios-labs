// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "Lab8DEventRegistration",
    platforms: [
        .iOS(.v16),
        .macOS(.v13)
    ],
    products: [
        .library(name: "EventRegistrationCore", targets: ["EventRegistrationCore"])
    ],
    targets: [
        .target(name: "EventRegistrationCore"),
        .testTarget(name: "EventRegistrationCoreTests", dependencies: ["EventRegistrationCore"])
    ]
)
