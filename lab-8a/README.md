# Lab 8A: Course Explorer

The project is a small SwiftUI Course Explorer with category chips, reusable configurable course cards, status badges, an empty state, and a course detail screen.

## Source layout

- `App/Lab8AApp.swift` — app entry point.
- `App/CourseExplorerScreen.swift` — navigation and course browsing.
- `App/CourseCard.swift`, `App/StatusBadge.swift`, `App/CategoryPill.swift`, `App/SectionHeading.swift`, `App/ExplorerHeader.swift` — reusable components.
- `App/CourseDetailScreen.swift` and `App/CourseEmptyState.swift` — detail and empty views.
- `Sources/CourseExplorerCore/Course.swift` — platform-independent course model and sample data.

See [component-tree.md](./component-tree.md) for the hierarchy. Xcode previews for populated and empty screens are defined in `CourseExplorerScreen.swift`. They require Xcode on macOS.

Run `swift test` from this folder to test the core course model.
