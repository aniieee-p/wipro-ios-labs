# Lab 3: Compare UIKit and SwiftUI

## R1: Same Screen in UIKit and SwiftUI

Created two implementations of a Student Greeting screen.

Both implementations contain:
- A title: Student Greeting
- A text field to enter a student's name
- A Generate Greeting button
- A result label displaying the greeting or a validation message

## R2: SwiftUI State Management

Used `@State` properties to store the student's name and greeting result.

When the button is tapped, SwiftUI updates the result automatically because the view observes its state.

## R3: UIKit Actions

Created UIKit controls programmatically using `UILabel`, `UITextField`, and `UIButton`.

Connected the button using `addTarget(_:action:for:)`. The `generateGreeting` action validates the name and updates the result label.

## R4: Comparison Table

| Aspect | UIKit | SwiftUI |
|---|---|---|
| Amount of code | More setup code required | More concise |
| State updates | Manually update UI controls | Automatic through @State |
| Layout | Auto Layout constraints | Declarative view hierarchy |
| Previews | Run app or use storyboard | #Preview macro |
| Interoperability | Host SwiftUI via UIHostingController | Embed UIKit via UIViewRepresentable |

## R5: Recommendation

**Choose UIKit when:**
- Maintaining an existing UIKit codebase.
- Building complex interfaces that need fine-grained control.
- Using UIKit-specific APIs or integrating legacy components.

**Choose SwiftUI when:**
- Starting a new app targeting iOS 16+.
- Wanting less boilerplate and automatic state-driven updates.
- Iterating quickly with live previews.

Both frameworks can work together, so teams can adopt SwiftUI gradually inside a UIKit app using `UIHostingController`.
