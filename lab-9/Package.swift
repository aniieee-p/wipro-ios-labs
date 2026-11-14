// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "Lab9ConfigurationAudit",
    platforms: [
        .iOS(.v16),
        .macOS(.v13)
    ],
    products: [
        .library(name: "ConfigurationAuditCore", targets: ["ConfigurationAuditCore"])
    ],
    targets: [
        .target(name: "ConfigurationAuditCore"),
        .testTarget(name: "ConfigurationAuditCoreTests", dependencies: ["ConfigurationAuditCore"])
    ]
)
