import XCTest
@testable import ProfileFormCore

final class ProfileFormValidatorTests: XCTestCase {
    func testAcceptsCompleteProfile() {
        let input = ProfileFormInput(name: "Ada Lovelace", email: "ada@example.com", course: "Swift")

        XCTAssertTrue(ProfileFormValidator.validate(input).isEmpty)
    }

    func testRequiresName() {
        let input = ProfileFormInput(name: " \n ", email: "ada@example.com", course: "Swift")

        XCTAssertEqual(ProfileFormValidator.validate(input).fields[.name], "Enter your full name.")
    }

    func testRequiresEmail() {
        let input = ProfileFormInput(name: "Ada", email: " ", course: "Swift")

        XCTAssertEqual(ProfileFormValidator.validate(input).fields[.email], "Enter your email address.")
    }

    func testRejectsMalformedEmail() {
        let input = ProfileFormInput(name: "Ada", email: "ada@", course: "Swift")

        XCTAssertEqual(ProfileFormValidator.validate(input).fields[.email], "Enter a valid email address.")
    }

    func testRequiresCourse() {
        let input = ProfileFormInput(name: "Ada", email: "ada@example.com", course: "")

        XCTAssertEqual(ProfileFormValidator.validate(input).fields[.course], "Enter your course name.")
    }

    func testReportsAllMissingFieldsTogether() {
        let errors = ProfileFormValidator.validate(ProfileFormInput(name: "", email: "", course: ""))

        XCTAssertEqual(Set(errors.fields.keys), Set(ProfileField.allCases))
    }
}
