import XCTest
@testable import SwiftUICore

final class ContactFormValidatorTests: XCTestCase {

    // MARK: - Valid input

    func testValidInputProducesNoErrors() {
        let input = ContactFormInput(
            name: "Jane Doe",
            email: "jane@example.com",
            phone: "+44 7700 900123",
            message: "Hello, I would like more information please."
        )
        let errors = ContactFormValidator.validate(input)
        XCTAssertTrue(errors.isEmpty)
    }

    // MARK: - Name validation

    func testEmptyNameProducesError() {
        let input = ContactFormInput(name: "", email: "a@b.com", phone: "1234567", message: "Long enough message here.")
        let errors = ContactFormValidator.validate(input)
        XCTAssertNotNil(errors.fields[.name])
    }

    func testSingleCharacterNameProducesError() {
        let input = ContactFormInput(name: "A", email: "a@b.com", phone: "1234567", message: "Long enough message here.")
        let errors = ContactFormValidator.validate(input)
        XCTAssertNotNil(errors.fields[.name])
    }

    func testTwoCharacterNameIsAccepted() {
        let input = ContactFormInput(name: "Jo", email: "a@b.com", phone: "1234567", message: "Long enough message here.")
        let errors = ContactFormValidator.validate(input)
        XCTAssertNil(errors.fields[.name])
    }

    // MARK: - Email validation

    func testEmptyEmailProducesError() {
        let input = ContactFormInput(name: "Jane", email: "", phone: "1234567", message: "Long enough message here.")
        let errors = ContactFormValidator.validate(input)
        XCTAssertNotNil(errors.fields[.email])
    }

    func testEmailWithoutAtSignProducesError() {
        let input = ContactFormInput(name: "Jane", email: "notanemail", phone: "1234567", message: "Long enough message here.")
        let errors = ContactFormValidator.validate(input)
        XCTAssertNotNil(errors.fields[.email])
    }

    func testEmailWithoutDomainProducesError() {
        let input = ContactFormInput(name: "Jane", email: "user@nodot", phone: "1234567", message: "Long enough message here.")
        let errors = ContactFormValidator.validate(input)
        XCTAssertNotNil(errors.fields[.email])
    }

    func testValidEmailIsAccepted() {
        let input = ContactFormInput(name: "Jane", email: "user@example.co.uk", phone: "1234567", message: "Long enough message here.")
        let errors = ContactFormValidator.validate(input)
        XCTAssertNil(errors.fields[.email])
    }

    // MARK: - Phone validation

    func testEmptyPhoneProducesError() {
        let input = ContactFormInput(name: "Jane", email: "a@b.com", phone: "", message: "Long enough message here.")
        let errors = ContactFormValidator.validate(input)
        XCTAssertNotNil(errors.fields[.phone])
    }

    func testPhoneWithLettersProducesError() {
        let input = ContactFormInput(name: "Jane", email: "a@b.com", phone: "ABCDEFG", message: "Long enough message here.")
        let errors = ContactFormValidator.validate(input)
        XCTAssertNotNil(errors.fields[.phone])
    }

    func testShortPhoneProducesError() {
        let input = ContactFormInput(name: "Jane", email: "a@b.com", phone: "123", message: "Long enough message here.")
        let errors = ContactFormValidator.validate(input)
        XCTAssertNotNil(errors.fields[.phone])
    }

    func testValidPhoneWithPlusAndSpacesIsAccepted() {
        let input = ContactFormInput(name: "Jane", email: "a@b.com", phone: "+1 800 555 0100", message: "Long enough message here.")
        let errors = ContactFormValidator.validate(input)
        XCTAssertNil(errors.fields[.phone])
    }

    // MARK: - Message validation

    func testEmptyMessageProducesError() {
        let input = ContactFormInput(name: "Jane", email: "a@b.com", phone: "1234567", message: "")
        let errors = ContactFormValidator.validate(input)
        XCTAssertNotNil(errors.fields[.message])
    }

    func testShortMessageProducesError() {
        let input = ContactFormInput(name: "Jane", email: "a@b.com", phone: "1234567", message: "Hi there.")
        let errors = ContactFormValidator.validate(input)
        XCTAssertNotNil(errors.fields[.message])
    }

    func testTenCharacterMessageIsAccepted() {
        let input = ContactFormInput(name: "Jane", email: "a@b.com", phone: "1234567", message: "1234567890")
        let errors = ContactFormValidator.validate(input)
        XCTAssertNil(errors.fields[.message])
    }

    // MARK: - Multiple errors at once

    func testAllEmptyFieldsProduceFourErrors() {
        let input = ContactFormInput(name: "", email: "", phone: "", message: "")
        let errors = ContactFormValidator.validate(input)
        XCTAssertEqual(errors.fields.count, 4)
    }

    // MARK: - Trimming

    func testWhitespaceOnlyNameIsRejected() {
        let input = ContactFormInput(name: "   ", email: "a@b.com", phone: "1234567", message: "Long enough message here.")
        let errors = ContactFormValidator.validate(input)
        XCTAssertNotNil(errors.fields[.name])
    }
}
