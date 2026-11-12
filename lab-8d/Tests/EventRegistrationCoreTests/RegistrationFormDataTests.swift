import XCTest
@testable import EventRegistrationCore

final class RegistrationFormDataTests: XCTestCase {
    func testEmptyFormIsInvalidAndExplainsRequiredFields() {
        let validation = RegistrationFormData().validation

        XCTAssertFalse(validation.isValid)
        XCTAssertEqual(validation.nameMessage, "Enter your name.")
        XCTAssertEqual(validation.emailMessage, "Enter your email address.")
        XCTAssertEqual(validation.ticketMessage, "Choose a ticket type.")
        XCTAssertEqual(validation.termsMessage, "Accept the terms to continue.")
    }

    func testCompleteFormWithValidEmailCanBeSubmitted() {
        let form = RegistrationFormData(
            fullName: "  Anish Kumar  ",
            email: "anish@example.com",
            ticketType: .student,
            acceptsTerms: true
        )

        XCTAssertTrue(form.validation.isValid)
    }

    func testRejectsMalformedEmailAddresses() {
        for email in ["not-an-email", "a@@example.com", "a@.example.com", "a@example.", "a @example.com"] {
            let form = RegistrationFormData(
                fullName: "Anish",
                email: email,
                ticketType: .general,
                acceptsTerms: true
            )

            XCTAssertNotNil(form.validation.emailMessage, "Expected \(email) to be rejected")
            XCTAssertFalse(form.validation.isValid)
        }
    }

    func testWhitespaceOnlyNameIsInvalid() {
        let form = RegistrationFormData(
            fullName: " \n ",
            email: "anish@example.com",
            ticketType: .general,
            acceptsTerms: true
        )

        XCTAssertEqual(form.validation.nameMessage, "Enter your name.")
        XCTAssertFalse(form.validation.isValid)
    }

    func testLongOptionalNotesArePreservedWithoutInvalidatingForm() {
        let longNotes = String(repeating: "Please provide step-free access. ", count: 300)
        let form = RegistrationFormData(
            fullName: "Anish",
            email: "anish@example.com",
            ticketType: .general,
            notes: longNotes,
            acceptsTerms: true
        )

        XCTAssertEqual(form.notes, longNotes)
        XCTAssertTrue(form.validation.isValid)
    }

    func testAccessibilityToggleDoesNotRequireAdditionalInformation() {
        let form = RegistrationFormData(
            fullName: "Anish",
            email: "anish@example.com",
            ticketType: .vip,
            needsAccessibilitySupport: true,
            acceptsTerms: true
        )

        XCTAssertTrue(form.validation.isValid)
    }
}
