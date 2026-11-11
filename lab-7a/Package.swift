// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "Lab7AProfileForm",
    platforms: [
        .iOS(.v16),
        .macOS(.v13)
    ],
    products: [
        .library(name: "ProfileFormCore", targets: ["ProfileFormCore"])
    ],
    targets: [
        .target(name: "ProfileFormCore"),
        .testTarget(name: "ProfileFormCoreTests", dependencies: ["ProfileFormCore"])
    ]
)
