import XCTest
@testable import UnitTestPracticeCore

final class ProfileFormValidatorTests: XCTestCase {
    func testAcceptsCompleteProfile() {
        let input = ProfileFormInput(name: "Ada Lovelace", email: "ada@example.com", course: "Swift")

        XCTAssertTrue(ProfileFormValidator.validate(input).isEmpty)
    }

    func testTrimsWhitespaceAroundValidValues() {
        let input = ProfileFormInput(name: " Ada ", email: " ada@example.com ", course: " Swift ")

        XCTAssertTrue(ProfileFormValidator.validate(input).isEmpty)
    }

    func testRejectsWhitespaceOnlyName() {
        let input = ProfileFormInput(name: " \n ", email: "ada@example.com", course: "Swift")

        XCTAssertEqual(
            ProfileFormValidator.validate(input).fields[.name],
            "Enter your full name."
        )
    }

    func testRejectsMalformedEmail() {
        let input = ProfileFormInput(name: "Ada", email: "ada@", course: "Swift")

        XCTAssertEqual(
            ProfileFormValidator.validate(input).fields[.email],
            "Enter a valid email address."
        )
    }

    func testRejectsEmailContainingWhitespace() {
        let input = ProfileFormInput(name: "Ada", email: "ada @example.com", course: "Swift")

        XCTAssertEqual(
            ProfileFormValidator.validate(input).fields[.email],
            "Enter a valid email address."
        )
    }

    func testReportsAllMissingFieldsTogether() {
        let errors = ProfileFormValidator.validate(ProfileFormInput(name: "", email: "", course: ""))

        XCTAssertEqual(Set(errors.fields.keys), Set(ProfileField.allCases))
    }
}
