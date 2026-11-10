# Lab 6: Network-Driven People Directory

## Public test API

- Provider: [JSONPlaceholder](https://jsonplaceholder.typicode.com/)
- Endpoint: `https://jsonplaceholder.typicode.com/users`
- HTTP method: `GET`
- Response: JSON array of user objects, including nested `address` and `company` objects.

The app fetches the directory at runtime; it does not pretend bundled sample data came from the network. The list supports local search and opens a detail screen for each person.

## Run

Open the `Package.swift` in Xcode on macOS and add `DirectoryCore` as a local package dependency to an iOS App target. Add the three source files in `App/` to that target. Run on an iOS 16+ simulator or device with internet access.

Run `swift test` in this folder for the six network-service tests.

The SVG files in `screenshots/` are illustrative UI previews, not screenshots captured from a running simulator. This workspace runs on Windows and has no Xcode or iOS Simulator. Capture simulator screenshots of both the loaded list and the error/retry screen when an Apple development environment is available.

- [Success-state preview](./screenshots/directory-success-preview.svg)
- [Error-state preview](./screenshots/directory-error-preview.svg)

## Avoiding excessive requests

Search filters the already-loaded list locally and does not issue another request per keystroke. A production directory can also debounce user input, cache successful responses, paginate server-side, and cancel obsolete in-flight searches.
