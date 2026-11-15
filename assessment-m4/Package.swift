// swift-tools-version: 6.0
import PackageDescription

// AssessmentM4 — SwiftUI and Configuration
//
// Package structure:
//   Sources/SwiftUICore  — testable models and validators (no UIKit/SwiftUI imports)
//   Tests/SwiftUICoreTests — unit tests for the core logic
//   App/                 — SwiftUI views and app entry point (Xcode target only)
//
// The App/ folder is NOT a Swift Package target; it belongs to the
// Xcode application target (AssessmentM4.xcodeproj).  `swift test` runs
// only the Sources/Tests targets, which is intentional: view code is
// tested through the simulator in Xcode.

let package = Package(
    name: "AssessmentM4",
    platforms: [
        .iOS(.v16),
        .macOS(.v13)
    ],
    products: [
        .library(name: "SwiftUICore", targets: ["SwiftUICore"])
    ],
    targets: [
        .target(name: "SwiftUICore"),
        .testTarget(name: "SwiftUICoreTests", dependencies: ["SwiftUICore"])
    ]
)
