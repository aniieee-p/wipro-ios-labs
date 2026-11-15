# Milestone 4 Viva Notes

## 1. @State vs @Binding

### In plain words

`@State` creates a piece of data that a view **owns**. SwiftUI stores it outside the view struct so it survives redraws. When the value changes, every view reading it re-renders.

`@Binding` is a **reference into someone else's `@State`**. The view holds no data of its own; it reads and writes the parent's storage. Changes made through the binding are immediately visible everywhere that `@State` is used.

Rule of thumb: `@State` goes in the view that is the single source of truth. `@Binding` goes in child views that need to read or change that data.

### Code example

```swift
// Parent owns the data
struct BookListView: View {
    @State private var favourites = FavouritesStore()   // ← @State

    var body: some View {
        NavigationLink(destination: BookDetailView(favourites: $favourites)) {
            Text("Open detail")
        }
    }
}

// Child shares the same storage via @Binding
struct BookDetailView: View {
    @Binding var favourites: FavouritesStore            // ← @Binding

    var body: some View {
        Button("Toggle") {
            favourites.toggle("swift-prog")             // mutates parent's @State
        }
    }
}
```

When `BookDetailView` calls `favourites.toggle(...)`, the value inside `BookListView`'s `@State` changes and both views re-render. There is only one copy of the data.

---

## 2. App protocol/type vs View protocol/type

### App protocol

```swift
@main
struct AssessmentM4App: App {
    var body: some Scene {       // returns a Scene, not a View
        WindowGroup {
            BookListView()       // the root View
        }
    }
}
```

- Conforms to `App` (from SwiftUI).
- `@main` tells the compiler this is the entry point; Swift generates `main()` for it.
- `body` returns a `Scene` (`WindowGroup`, `DocumentGroup`, etc.).
- There is exactly **one** `App` type per application.

### View protocol

```swift
struct BookListView: View {
    var body: some View {        // returns a View
        NavigationStack { … }
    }
}
```

- Conforms to `View` (also from SwiftUI).
- `body` returns another `View`.
- Views compose freely; you can nest them arbitrarily.
- There are **many** `View` types in an app.

### Key difference

| | `App` | `View` |
|---|---|---|
| `body` returns | `Scene` | `View` |
| Count per app | exactly 1 | many |
| Purpose | bootstraps the window | describes a piece of UI |
| Marked with | `@main` | — |

---

## 3. NavigationStack

`NavigationStack` (iOS 16+) is a container that manages a navigation path — an ordered list of values representing the screens currently pushed.

```swift
@State private var path: [Book] = []

NavigationStack(path: $path) {
    // Root view
    List(books) { book in
        NavigationLink(value: book) {   // push a Book value onto the path
            Text(book.title)
        }
    }
    .navigationDestination(for: Book.self) { book in
        BookDetailView(book: book, …)   // SwiftUI asks "what view for this Book?"
    }
}
```

- **`NavigationLink(value:)`** pushes a *value* (not a destination view) onto the path.
- **`.navigationDestination(for:)`** maps a type to the view to display for it.
- The **back button** is automatic; tapping it pops the top value off the path.
- You can programmatically navigate by appending/removing values from `path`.

Contrast with the old `NavigationView` + `NavigationLink(destination:)` which mixed destination logic into each row.

---

## 4. State synchronization

State is synchronized when **one `@State` variable serves as the single source of truth** and all views that need to change it receive a `@Binding`.

In this project:

```
BookListView
  @State private var favourites = FavouritesStore()
      │
      │  $favourites  (Binding<FavouritesStore>)
      ▼
  BookDetailView
      @Binding var favourites: FavouritesStore
```

Steps that keep them in sync:

1. User taps ♥ on `BookDetailView`.
2. The `@Binding` setter runs, updating the `FavouritesStore` inside `BookListView`'s `@State`.
3. SwiftUI sees the state change and re-renders **both** `BookListView` and `BookDetailView`.
4. The ♥ badge on the list row appears/disappears without any manual notification.

There is no Observer pattern, no delegate, and no notification — the binding wires the two views to the same storage automatically.

---

## 5. Quick cheat sheet

| Concept | One-line summary |
|---|---|
| `@State` | View owns the data; SwiftUI persists it across redraws. |
| `@Binding` | View borrows read/write access to a parent's `@State`. |
| `@main` + `App` | Marks the app's single entry point; `body` returns a `Scene`. |
| `View` | Building block of UI; `body` returns another `View`. |
| `NavigationStack` | iOS 16+ navigation container driven by a typed path array. |
| `NavigationLink(value:)` | Pushes a value; matched by `.navigationDestination(for:)`. |
| State sync | One `@State` + multiple `@Binding`s = one copy, many views. |
