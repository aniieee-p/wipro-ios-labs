// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "Lab4A",
    platforms: [
        .iOS(.v16),
        .macOS(.v13)
    ],
    products: [
        .library(name: "TaskListCore", targets: ["TaskListCore"]),
        .library(name: "TaskListMVC", targets: ["TaskListMVC"]),
        .library(name: "TaskListMVVM", targets: ["TaskListMVVM"])
    ],
    targets: [
        .target(name: "TaskListCore"),
        .target(name: "TaskListMVC", dependencies: ["TaskListCore"]),
        .target(name: "TaskListMVVM", dependencies: ["TaskListCore"]),
        .testTarget(name: "TaskListCoreTests", dependencies: ["TaskListCore"])
    ]
)
