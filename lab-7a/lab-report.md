# Lab 7A: UIKit Profile Form

## Requirements

| Requirement | Implementation |
|---|---|
| R1: Name, email, course, and submit controls in UIKit | `ProfileFormViewController` builds the complete screen programmatically from UIKit views. |
| R2: Auto Layout, no fixed screen positioning | A vertical stack is constrained inside a scroll view; its width follows the safe-area width, and `keyboardLayoutGuide` keeps content visible above the keyboard. |
| R3: Required-field and email validation | `ProfileFormValidator` returns per-field messages. The controller displays inline errors and an accessible status announcement. |
| R4: Keyboard, content type, accessibility, dismissal | Fields configure appropriate content types, keyboard, capitalization, autocorrection, return-key navigation, and accessibility labels. Tapping outside or submitting dismisses the keyboard. |
| R5: Two portrait simulator sizes | The layout uses adaptive Auto Layout and a scroll view. Two portrait-size SVG previews are included in [screenshots/](./screenshots/); they are illustrative, not simulator captures. Verify on two iPhone simulators using Xcode on macOS. |
| Extension: Dynamic Type and appearance | Text uses preferred text styles with `adjustsFontForContentSizeCategory`; colors use system semantic colors for light/dark appearance. |

## Validation tests

The test target covers a valid profile, missing name, missing email, malformed email, missing course, and reporting all required-field errors together. Run `swift test` from this folder.

## Run

Open [Lab7A.xcodeproj](./Lab7A.xcodeproj) on macOS and run the Lab7A target on an iOS 16+ simulator or device. The project compiles the validator source directly into the app target. Its scene manifest uses `Lab7ASceneDelegate`, which creates a navigation controller containing the UIKit form.

This workspace runs on Windows without Xcode or the iOS Simulator. The included SVGs are screen previews rather than native screenshots. On macOS, run in portrait on two simulator sizes and capture both validation and success states if required.
