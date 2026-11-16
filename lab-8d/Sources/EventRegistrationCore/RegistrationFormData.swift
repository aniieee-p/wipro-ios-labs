
import Foundation

public enum TicketType: String, CaseIterable, Identifiable, Sendable {
    case general = "General admission"
    case student = "Student"
    case vip = "VIP"

    public var id: String {
        rawValue
    }
}

public struct RegistrationFormData: Equatable, Sendable {
    public var fullName: String
    public var email: String
    public var ticketType: TicketType?
    public var needsAccessibilitySupport: Bool
    public var notes: String
    public var acceptsTerms: Bool

    public init(
        fullName: String = "",
        email: String = "",
        ticketType: TicketType? = nil,
        needsAccessibilitySupport: Bool = false,
        notes: String = "",
        acceptsTerms: Bool = false
    ) {
        self.fullName = fullName
        self.email = email
        self.ticketType = ticketType
        self.needsAccessibilitySupport = needsAccessibilitySupport
        self.notes = notes
        self.acceptsTerms = acceptsTerms
    }

    public var validation: RegistrationValidation {
        RegistrationValidation(form: self)
    }
}

public struct RegistrationValidation: Equatable, Sendable {
    public let nameMessage: String?
    public let emailMessage: String?
    public let ticketMessage: String?
    public let termsMessage: String?

    public var isValid: Bool {
        nameMessage == nil
            && emailMessage == nil
            && ticketMessage == nil
            && termsMessage == nil
    }

    init(form: RegistrationFormData) {
        let name = form.fullName.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        nameMessage = name.isEmpty ? "Enter your name." : nil

        ticketMessage = form.ticketType == nil
            ? "Choose a ticket type."
            : nil

        termsMessage = form.acceptsTerms
            ? nil
            : "Accept the terms to continue."

        let email = form.email.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        if email.isEmpty {
            emailMessage = "Enter your email address."
        } else if !email.contains("@") || !email.contains(".") {
            emailMessage = "Enter a valid email address."
        } else {
            emailMessage = nil
        }
    }
}
