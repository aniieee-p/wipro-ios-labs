# Lab 6: Build a Network-Driven Directory

## Requirements

| Requirement | Implementation |
|---|---|
| R1: Choose a public test API and record endpoint | [README.md](./README.md) records the JSONPlaceholder endpoint `https://jsonplaceholder.typicode.com/users`. |
| R2: Define Codable response models | `DirectoryUser` decodes user fields plus nested address and company data. |
| R3: Use URLSession async/await and URL building | `UserDirectoryService` validates an HTTPS URL using `URLComponents`; `URLSessionDirectoryTransport` builds a `URLRequest` and calls `URLSession.shared.data(for:)`. |
| R4: Decode and display list and detail | `JSONDecoder` decodes the runtime response. SwiftUI shows people in a searchable list with a navigation detail view. |
| R5: Handle URL, HTTP, decoding, empty, and network outcomes | `DirectoryError` distinguishes invalid URL, non-2xx HTTP status, decoding error, and transport failure. Empty arrays have their own UI state. |
| R6: Loading and retry states | The view model exposes loading, success, empty, failure, and cancelled states. The screen offers cancellation during loading and retry after an error. |
| R7: Separate network code from UI | The `DirectoryCore` service depends on a `DirectoryTransport` protocol; the app supplies the URLSession implementation, and tests inject a stub transport. |
| Extension: Search and request throttling | Search is local, so typing does not cause network requests. README explains debounce, cache, cancellation, and server pagination. |

## Tests

Six service tests cover successful nested decoding, invalid endpoint, non-success HTTP status, malformed JSON, empty response, and network failure. All six passed on Windows with Swift 6.4.2; see [test-output.md](./test-output.md).

## Screenshots

The `screenshots/` SVGs are illustrative success and error-state previews only, not simulator captures. The project is authored in a Windows workspace without Xcode or the iOS Simulator, so native screenshots must be captured on macOS.
