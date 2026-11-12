# Milestone 3: Networking and UIKit

## Requirements

| Requirement | Implementation |
|---|---|
| R1: UIKit form with validation and Auto Layout | `ProfileFormViewController` builds a keyboard-aware, scrollable UIKit form. `ProfileFormValidator` validates required name/email/course and email shape; field errors appear inline. |
| R2: Decode JSON and render list | `UserDirectoryService` fetches JSONPlaceholder users with URLSession async/await and decodes `DirectoryUser` using `JSONDecoder`. A table view renders the result. |
| R3: Loading, empty, and failure states | `DirectoryViewModel.State` models loading, success, empty, failure, and cancellation; the list controller renders each and offers retry. |
| R4: Navigate list to detail | Selecting a row pushes `DirectoryDetailViewController(user:profile:)`. The selected model is passed directly, not stored globally. |
| R5: Viva topics | [viva-notes.md](./viva-notes.md) explains the view hierarchy, constraints, URLSession, Codable, and main actor. |

## Test coverage

The portable test target covers valid and invalid profiles, nested Codable decoding, non-success HTTP status, malformed JSON, empty response, and network failure. All eight tests passed with Swift 6.4.2 on Windows; see [test-output.md](./test-output.md). UI interaction and live network behavior require an iOS simulator or device.

## API endpoint

`GET https://jsonplaceholder.typicode.com/users` (public classroom test API).
