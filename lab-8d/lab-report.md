# Lab 8D: SwiftUI Layout and Form Interaction

## Requirements

| Requirement | Implementation |
|---|---|
| R1: Event form with text fields, picker, toggle, and submit | [EventRegistrationView.swift](./App/EventRegistrationView.swift) includes name/email fields, a ticket picker, accessibility and terms toggles, optional multiline notes, and a review action. |
| R2: Deliberate `Form`, `Section`, padding, spacing, and alignment | The screen groups related controls with `Form` sections. The event header uses aligned stacks, adaptive-width layout, and deliberate padding/spacing; error messages and long text wrap vertically. |
| R3: Validation feedback and success confirmation | [RegistrationFormData.swift](./Sources/EventRegistrationCore/RegistrationFormData.swift) validates required values and email format; inline messages update with input. A successful confirmation follows the review screen. |
| R4: Disable submission until required values are complete | The review action is disabled unless name, email, ticket choice, and terms all pass validation. |
| R5: Test long text, empty input, and small-screen layout | Core tests cover empty fields, whitespace-only names, malformed email addresses, and long optional notes. The manual device checklist below covers small screens and dynamic text. |
| Extension: Review before submission | `RegistrationReviewView` summarizes the entered information and lets the user edit or confirm registration. |

## State and validation

`EventRegistrationView` owns its form as `@State`; all controls write to this one form value through SwiftUI bindings. `RegistrationFormData.validation` derives field messages and a single `isValid` result from the current input. No submit handler can bypass the disabled-state rule through the UI. Optional notes are not capped or treated as required.

## Test cases

Automated core cases are in [RegistrationFormDataTests.swift](./Tests/EventRegistrationCoreTests/RegistrationFormDataTests.swift):

1. Empty input shows required-field errors and cannot submit.
2. A whitespace-only name is rejected.
3. Malformed or whitespace-containing email addresses are rejected.
4. A complete registration is valid.
5. A long optional note is preserved and does not invalidate a complete form.
6. Requesting accessibility support does not introduce an undocumented required field.

Manual simulator checks for R5:

1. On a compact iPhone simulator, scroll through the form, open the ticket picker, and confirm the review screen remains reachable without horizontal clipping.
2. Paste a multi-paragraph note into the optional notes field; confirm text wraps, grows within its line limit, and the form remains vertically scrollable.
3. Leave each required input empty in turn; confirm the review button stays disabled and the related validation message is visible.
4. Enter an invalid email, then correct it; confirm the validation message clears and the review action enables when all other requirements are complete.
5. Enable a larger accessibility text size and verify labels/errors wrap without overlapping controls.

## Run and screenshots

Open [Package.swift](./Package.swift) with Xcode on macOS, add `EventRegistrationCore` as a local package dependency to an iOS App target, and include the Swift files in `App/` in the target. Run on an iOS 16+ simulator or device. Run `swift test` in this folder for the validation tests.

The SVGs in [screenshots/](./screenshots/) are illustrative previews, not captures from the running app. This Windows workspace has no working Swift toolchain, Xcode, or iOS Simulator; run the app on macOS to validate the UI and capture native screenshots.
