# Configuration Audit Checklist

## Audited Xcode project in this workspace

The checked-in configuration evidence below is from the existing `Lab7A` project at `../lab-7a/Lab7A.xcodeproj/`. This identifies an actual project target available in the workspace; it is not a claim that the separate Swift package in this folder already has an Xcode project or has been opened in Xcode.

| Item | Observed value | Scope / evidence |
|---|---|---|
| Project and app target | Project `Lab7A`; one application target named `Lab7A` | Target declaration in `../lab-7a/Lab7A.xcodeproj/project.pbxproj` |
| Bundle identifier | `com.example.wipro.lab7a` in Debug and Release | Target build configurations; sample-style identifier, replace with a registered unique identifier before distribution |
| App version | `1.0` | `CFBundleShortVersionString` in `../lab-7a/App/Info.plist` |
| Build number | `1` | `CFBundleVersion` in `../lab-7a/App/Info.plist` |
| Deployment target | iOS 16.0 | Project and target build settings |
| Supported platforms / device family | iPhone and iOS Simulator; iPhone device family (`1`) | Target build settings `SUPPORTED_PLATFORMS`, `TARGETED_DEVICE_FAMILY` |
| Signing | Automatic signing style | Target Debug and Release build settings; team identity is not specified in the checked-in project |
| Supported orientations | Portrait only | `UISupportedInterfaceOrientations` in `../lab-7a/App/Info.plist` |
| App targets | Single app target; no separate extension target observed | Project target list |
| Privacy descriptions | No privacy-purpose keys are present | `../lab-7a/App/Info.plist`; the profile form does not need protected device resources |

## Settings checklist

- [x] Inspect the project and app target.
- [x] Record bundle identifier, marketing version, build number, deployment target, supported platforms/device family, and signing style from the project files.
- [x] Record the orientation declaration from the Info.plist.
- [x] Check Info.plist for permission-purpose descriptions.
- [x] Use a local checklist feature that requests no sensitive permission.
- [x] Document which settings are project-, target-, and build-configuration-level.
- [ ] In Xcode on macOS, inspect the target settings UI and capture a native screenshot.
- [ ] Before release, replace the example bundle identifier and configure the appropriate Apple development team/signing profile in Xcode.

## Privacy and permission decision

The included configuration checklist is a local UI feature. It toggles checklist items in memory; it does not access photos, location, camera, microphone, contacts, tracking, or the network. Therefore it needs no permission request or privacy usage-description key. No permission is added just to demonstrate a purpose string.

## Per-target and per-build configuration

This repository's Lab 7A target has Debug and Release configurations that currently share the same bundle identifier, iOS deployment target, supported platforms, device family, Info.plist path, Swift version, and automatic signing style. Project-level Debug and Release settings also declare the iOS SDK, deployment target, and Swift version. The sample `.xcconfig` files in this folder demonstrate separating common values into `Base.xcconfig` and build-specific optimization/debug-information settings into Debug and Release files; they are examples, not settings already assigned to an Xcode target.

## Screenshots and evidence

See the SVG previews in [screenshots/](./screenshots/). They are illustrative documentation, not screenshots captured from Xcode or a simulator. This workspace is Windows-only and cannot provide native Xcode target-settings screenshots. On macOS, open `../lab-7a/Lab7A.xcodeproj`, select the Lab7A app target, and capture the **General**, **Signing & Capabilities**, and **Build Settings** views. Do not expose personal team identifiers or signing details in a public screenshot.
