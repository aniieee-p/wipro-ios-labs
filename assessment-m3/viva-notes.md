# Milestone 3 viva notes

## View hierarchy

UIKit views form a parent-child tree. A window hosts the root navigation controller; it hosts the visible view controller's root view; that view contains a scroll view, stack views, labels, fields, and buttons. A table view owns reusable cells and each cell's `contentView` owns its visible text. Adding a child view makes it part of its parent's layout and drawing tree. The Xcode View Debugger can inspect the live tree and constraint relationships.

## Auto Layout constraints

Constraints describe relationships rather than absolute screen coordinates. For example, the profile form's scroll view is pinned to the safe area and keyboard layout guide, while its stack is pinned to the scroll view's content layout guide and width. The scroll view can grow vertically as validation messages appear, and the keyboard reduces the available visible area. This adapts to device size, orientation, Dynamic Type, and keyboard presentation.

## URLSession

`URLSession` performs HTTP transfers. `data(for:)` is its async/await API for a request: it suspends while network I/O runs and returns data plus a URL response. The service validates the URL and HTTP status before it attempts to decode. Transport errors and unsuccessful HTTP responses are distinct failure paths.

## Codable

`Codable` is the combination of `Encodable` and `Decodable`. `JSONDecoder` maps JSON keys to typed Swift properties. Nested JSON objects become nested Codable structs (`Address` and `Company`), and the decoded values can be passed around as models instead of untyped dictionaries.

## Main actor

`DirectoryViewModel` is `@MainActor` because its state drives UIKit. The service does asynchronous networking; when the awaited request completes, the view model changes its state on the main actor. UIKit view mutations remain on the main thread, which coordinates interaction and rendering.
