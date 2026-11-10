// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "Lab6Directory",
    platforms: [
        .iOS(.v16),
        .macOS(.v13)
    ],
    products: [
        .library(name: "DirectoryCore", targets: ["DirectoryCore"])
    ],
    targets: [
        .target(name: "DirectoryCore"),
        .testTarget(name: "DirectoryCoreTests", dependencies: ["DirectoryCore"])
    ]
)
