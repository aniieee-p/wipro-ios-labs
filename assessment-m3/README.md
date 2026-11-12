# Milestone 3: Networking and UIKit

## Run the app

Open [AssessmentM3.xcodeproj](./AssessmentM3.xcodeproj) on macOS and run the `AssessmentM3` target on an iOS 16+ simulator or device with internet access. No external package dependencies are required; the Xcode app target includes the core Swift sources directly.

1. Complete the name, email, and course form. Invalid or missing values show inline messages.
2. On valid input, the app pushes the people directory screen.
3. The directory uses `URLSession` to fetch `https://jsonplaceholder.typicode.com/users`, decodes its JSON into `DirectoryUser` values, and renders a UIKit table view.
4. Loading, empty, network failure, and cancellation states are displayed. Retry is available after a terminal error.
5. Select a person to push their detail screen; Back returns to the list.

## Architecture

```text
ProfileFormViewController
  └── ProfileFormValidator
  └── valid submit pushes DirectoryListViewController(profile:)
        └── DirectoryViewModel (@MainActor)
              └── UserDirectoryService
                    ├── URLSessionDirectoryTransport
                    └── JSONDecoder → [DirectoryUser]
        └── select row pushes DirectoryDetailViewController(user:profile:)
```

The service is independent of UIKit and accepts a `DirectoryTransport`, allowing response and error behavior to be tested without network access. The destination detail screen receives the selected user explicitly; there is no global selected-user variable.

## Test

Run `swift test` in this folder for profile validation, JSON decoding, HTTP errors, empty results, and transport failure tests.
The eight core test results are recorded in [test-output.md](./test-output.md).

## Screenshots

The [success preview](./screenshots/directory-success-preview.svg) and [failure preview](./screenshots/directory-failure-preview.svg) are illustrative only, not simulator captures. Native screenshots require Xcode and the iOS Simulator on macOS.
