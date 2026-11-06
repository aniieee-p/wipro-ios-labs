\# Lab 3: Compare UIKit and SwiftUI



\## R1: Same Screen in UIKit and SwiftUI



Created two implementations of a Student Greeting screen.



Both implementations contain:

\- A title: Student Greeting

\- A text field to enter a student's name

\- A Generate Greeting button

\- A result label displaying the greeting or a validation message



\## R2: SwiftUI State Management



Used `@State` properties to store the student's name and greeting result.



When the button is tapped, SwiftUI updates the result automatically because the view observes its state.



\## R3: UIKit Actions



Created UIKit controls programmatically using `UILabel`, `UITextField`, and `UIButton`.



Connected the button using `addTarget(\_:action:for:)`. The `generateGreeting` action validates the name and updates the result label.



\## R4: UIKit and SwiftUI Comparison



| Aspect | UIKit | SwiftUI |

|---|---|---|

| Amount of code | More setup code | More concise |

| State updates | Manually update UI controls | Automatic through state |

| Layout | Constraints and UIStackView | Declarative view hierarchy |

| Previews | Storyboards or running the app | SwiftUI previews |

| Interoperability | Can host SwiftUI using UIHostingController | Can embed UIKit using UIViewRepresentable |



\## R5: Recommendation



\*\*Choose UIKit when:\*\*

\- Maintaining an existing UIKit application.

\- Building complex interfaces requiring detailed control.

\- Working with UIKit-specific APIs or legacy components.



\*\*Choose SwiftUI when:\*\*

\- Building a new application with modern Apple platforms.

\- Creating interfaces quickly with less code.

\- Using declarative layouts and automatic state updates.



Both frameworks can work together, so teams can adopt SwiftUI gradually in existing UIKit applications.



\## Conclusion



This lab demonstrates the difference between imperative UI construction in UIKit and declarative UI construction in SwiftUI. Both implementations provide the same functionality using their respective approaches.

