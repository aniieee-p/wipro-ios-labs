
import XCTest

final class Lab7AProfileFlowUITests: XCTestCase {
    private var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func testUserSubmitsCompleteProfileAndSeesSuccess() throws {
        let nameField = app.textFields["profileName"]
        let emailField = app.textFields["profileEmail"]
        let courseField = app.textFields["profileCourse"]
        let submitButton = app.buttons["profileSubmit"]
        let statusLabel = app.staticTexts["profileStatus"]

        XCTAssertTrue(nameField.waitForExistence(timeout: 5))
        XCTAssertTrue(emailField.exists)
        XCTAssertTrue(courseField.exists)
        XCTAssertTrue(submitButton.exists)

        nameField.tap()
        nameField.typeText("Ada Lovelace")

        emailField.tap()
        emailField.typeText("ada@example.com")

        courseField.tap()
        courseField.typeText("Swift")

        submitButton.tap()

        XCTAssertTrue(statusLabel.waitForExistence(timeout: 5))
        XCTAssertEqual(
            statusLabel.label,
            "Profile submitted successfully."
        )
    }

    func testSubmittingEmptyFormShowsValidationError() throws {
        let submitButton = app.buttons["profileSubmit"]
        let statusLabel = app.staticTexts["profileStatus"]

        XCTAssertTrue(submitButton.waitForExistence(timeout: 5))

        submitButton.tap()

        XCTAssertTrue(statusLabel.waitForExistence(timeout: 5))
        XCTAssertEqual(
            statusLabel.label,
            "Please correct the highlighted fields."
        )
    }

    func testInvalidEmailShowsValidationErrorInsteadOfSuccess() throws {
        let nameField = app.textFields["profileName"]
        let emailField = app.textFields["profileEmail"]
        let courseField = app.textFields["profileCourse"]
        let submitButton = app.buttons["profileSubmit"]
        let statusLabel = app.staticTexts["profileStatus"]

        XCTAssertTrue(nameField.waitForExistence(timeout: 5))
        XCTAssertTrue(emailField.exists)
        XCTAssertTrue(courseField.exists)
        XCTAssertTrue(submitButton.exists)

        nameField.tap()
        nameField.typeText("Ada Lovelace")

        emailField.tap()
        emailField.typeText("not-an-email")

        courseField.tap()
        courseField.typeText("Swift")

        submitButton.tap()

        XCTAssertTrue(statusLabel.waitForExistence(timeout: 5))
        XCTAssertEqual(
            statusLabel.label,
            "Please correct the highlighted fields."
        )
        XCTAssertFalse(statusLabel.label.contains("successfully"))
    }
}
