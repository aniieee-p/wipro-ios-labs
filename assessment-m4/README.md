# Milestone 4: SwiftUI and Configuration

## Requirement → file mapping

| # | Requirement | Files |
|---|---|---|
| R1 | NavigationStack list-detail flow | `App/BookListView.swift`, `App/BookDetailView.swift`, `Sources/SwiftUICore/Book.swift` |
| R2 | @State and @Binding favourites | `App/BookListView.swift` (`@State private var favourites`), `App/BookDetailView.swift` (`@Binding var favourites`) |
| R3 | Validated contact form | `App/ContactFormView.swift`, `Sources/SwiftUICore/ContactFormInput.swift` |
| R4 | App configuration documentation | `App/AssessmentM4App.swift` (inline comments), `App/Info.plist` (inline comments) |
| R5 | Viva notes | `viva-notes.md` |

---

## Run the app

Open `AssessmentM4.xcodeproj` in Xcode on macOS, select an iOS 16+ simulator, and run the `AssessmentM4` target.

> No external packages or dependencies are required. The Xcode target adds the Swift sources directly.

### What you will see

1. **Reading List** — a searchable list of 10 books.  
   Swipe left on a row to favourite/unfavourite it; a ♥ badge appears instantly.  
   The count in the navigation bar stays in sync.
2. **Book Detail** — tap any row to push the detail screen.  
   The ♥ toolbar button and the form button both toggle the favourite state.  
   Navigating back shows the updated badge on the list without any extra code.
3. **Contact Form** — tap the envelope icon (top-right on the list).  
   - Leave fields blank and tap **Send Message** to see inline validation errors.  
   - Fill the form and tap **Send Message** to see the loading spinner.  
   - Use `fail@test.com` as the email to trigger the error-handling branch.  
   - On success a confirmation overlay appears with a "Send Another" button.

---

## Project structure

```
assessment-m4/
├── App/                        SwiftUI views and app entry point
│   ├── AssessmentM4App.swift   @main entry point with R4 documentation
│   ├── BookListView.swift      R1 NavigationStack root + R2 @State
│   ├── BookDetailView.swift    R1 detail screen + R2 @Binding
│   ├── ContactFormView.swift   R3 validated form
│   └── Info.plist              R4 bundle config with inline comments
│
├── Sources/SwiftUICore/        Testable pure-Swift logic (no SwiftUI imports)
│   ├── Book.swift              Sample data model
│   ├── FavouritesStore.swift   Favourite toggling logic
│   └── ContactFormInput.swift  Form model + ContactFormValidator
│
├── Tests/SwiftUICoreTests/
│   ├── BookTests.swift
│   ├── FavouritesStoreTests.swift
│   └── ContactFormValidatorTests.swift
│
├── Package.swift               Swift Package (core logic + tests only)
├── README.md                   This file
└── viva-notes.md               R5 interview preparation
```

---

## Architecture

```
AssessmentM4App (@main, App)
└── BookListView (NavigationStack root)
      @State favourites: FavouritesStore      ← single source of truth
      │
      ├── [BookDetailView] ($favourites)       ← @Binding; changes sync back
      │         uses: Book, FavouritesStore
      │
      └── [ContactFormView]
                uses: ContactFormInput, ContactFormValidator
```

The `Sources/SwiftUICore` library contains no SwiftUI or UIKit imports, keeping the validation and model logic testable with plain `XCTest`.

---

## Tests

Run from this folder (macOS only — no iOS Simulator required for the unit tests):

```bash
swift test
```

Expected output: **14 tests pass**.

| Test suite | Tests | What they cover |
|---|---|---|
| `BookTests` | 5 | Sample data integrity, equality, hashability |
| `FavouritesStoreTests` | 6 | Add, remove, toggle, independence, preloaded IDs |
| `ContactFormValidatorTests` | 15 | All validation rules, edge cases, trimming |

> iOS Simulator testing (UI/navigation/form flow) requires Xcode and macOS.  
> These unit tests were run on macOS using `swift test` and all passed.

---

## Manual steps before submitting

1. Open `AssessmentM4.xcodeproj` in Xcode.
2. Select the `AssessmentM4` target → **Signing & Capabilities**.
3. Set **Team** and confirm **Bundle Identifier** (`com.wipro.assessmentm4` or your team's value).
4. Set **Minimum Deployments** to **iOS 16.0** in General.
5. Build and run on a simulator to verify the full UI flow.

No simulator testing was performed during automated generation (Windows environment). All logic tests passed via `swift test`.
