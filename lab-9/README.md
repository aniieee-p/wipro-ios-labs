# Lab 9: Project Configuration Audit

## What this lab contains

- [Configuration checklist](./configuration-checklist.md) with an evidence-based audit of the existing Lab 7A Xcode project in this workspace.
- [App target Info.plist](./App/Info.plist) and example shared, Debug, and Release build configurations in [Configuration/](./Configuration/).
- A local configuration-audit checklist app in [App/ConfigurationChecklistView.swift](./App/ConfigurationChecklistView.swift). Its feature requires no sensitive device permission and stores no user data.
- The target-configuration assignment and Debug/Release comparison below.
- Illustrative screen previews in [screenshots/](./screenshots/). They are not captures from Xcode.

## Run and test

On macOS, create an iOS App target in Xcode, add the Swift files from `App/`, add `ConfigurationAuditCore` from this local Swift package, and select the matching `.xcconfig` for each target build configuration. Run on an iOS 16+ simulator. Run `swift test` in this folder for checklist model tests.

The `.xcconfig` files are examples to assign to an app target; they do not themselves create an Xcode project. Replace the sample bundle identifier with one registered for your app before device signing or distribution. Do not put signing certificates, private keys, provisioning profiles, or team credentials in source control.

## Configuration scope

- **Project-level:** shared project defaults and configuration lists that targets may inherit, such as a common Swift language version or SDK.
- **Target-level:** settings for a specific product, including bundle identifier, Info.plist path, supported device families, deployment target, and signing style.
- **Build-configuration-level:** values that vary between Debug and Release, such as optimization, compilation conditions, and debug information.
- **Info.plist:** app metadata and runtime declarations such as version/build substitutions, scene manifest, orientations, and permission purpose strings when a permission is actually used.

## Debug versus Release

Debug favors fast incremental builds and debugger support: `-Onone`, the `DEBUG` compilation condition, and DWARF debug information. Release uses `-O`, a `RELEASE` compilation condition, and a dSYM-oriented debug-information format. Both configurations share the same app identity, version, deployment target, supported platforms, and Info.plist path in the base configuration. Signing identity/team should be selected per developer/team and provisioning environment in Xcode, not checked into these files.

## Privacy

The checklist feature uses no protected resource, so this sample Info.plist intentionally has **no** photo, location, camera, microphone, contacts, or tracking usage description. Add a purpose string only when the app actually uses the corresponding API, and explain the purpose clearly before requesting authorization.
