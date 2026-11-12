# Lab 8A: SwiftUI App Structure and Views

## Requirements

| Requirement | Implementation |
|---|---|
| R1: Course title, cards, categories, detail screen | `CourseExplorerScreen` shows a branded header, category pills, course cards, and a typed navigation destination. |
| R2: Use required SwiftUI containers and reusable views | The screen composes `VStack`, `HStack`, `ZStack`, `ScrollView`, and `LazyVGrid`. Reusable components include `ExplorerHeader`, `SectionHeading`, `CategoryPill`, `CourseCard`, `StatusBadge`, `CourseDetailScreen`, and `CourseEmptyState`. A `List` is not suited to this card-grid catalog; the grid provides compact browsing and card sizing. |
| R3: Previews / layout iteration | `CourseExplorerScreen` has sample-content and empty-state previews. The Xcode project is ready for simulator previews and device-size checks on macOS. |
| R4: Readable view bodies | Layout sections and components are extracted into focused view files and computed properties. See [component-tree.md](./component-tree.md). |
| R5: Empty state | Initialize `CourseExplorerScreen(courses: [])` to display `CourseEmptyState`; an Xcode preview is included. |
| Extension: Configurable course card | `CourseCard(title:subtitle:status:)` supports direct reusable configuration; the model initializer also supplies category art and styling. |

## Run and test

Open [Package.swift](./Package.swift) with Xcode on macOS, add `CourseExplorerCore` as a local package dependency to an iOS App target, and include the files in `App/` in the target. Run on an iOS 16+ simulator or device. Alternatively, open the package and create an iOS app target that depends on the local core package.

Run `swift test` in this folder for the course model tests. This Windows workspace does not include Xcode, SwiftUI rendering, or an iOS Simulator, so native layout previews and screenshots could not be captured here.
