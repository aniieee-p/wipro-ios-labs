# Lifecycle and keyboard observation guide

## Navigation experiment

1. Launch the app and note the first Settings lifecycle events in the Xcode console.
2. Tap **Open lifecycle detail** and observe Settings disappear and Detail appear.
3. Use the navigation Back button. Settings appears again; `viewDidLoad` should not repeat for the same controller instance.
4. Compare the console with the **Recent lifecycle events** panel. Callback ordering around transitions can vary slightly.

## Keyboard experiment

1. Tap **Your name** to present the keyboard.
2. Scroll the form and confirm controls remain reachable above the keyboard.
3. Tap another control or the blank area / press Return to dismiss it.
4. Confirm the form returns to its normal scroll layout.

The form uses both `keyboardLayoutGuide` and keyboard-frame notifications with scroll insets. A simulator run is needed to verify the visual result on the selected iOS version and device size.
