import Foundation

public enum TicketType: String, CaseIterable, Identifiable, Sendable {
    case general = "General admission"
    case student = "Student"
    case vip = "VIP"

    public var id: Self { self }
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

    fileprivate init(form: RegistrationFormData) {
        let name = form.fullName.trimmingCharacters(in: .whitespacesAndNewlines)
        nameMessage = name.isEmpty ? "Enter your name." : nil
        emailMessage = Self.emailMessage(for: form.email)
        ticketMessage = form.ticketType == nil ? "Choose a ticket type." : nil
        termsMessage = form.acceptsTerms ? nil : "Accept the terms to continue."
    }

    private static func emailMessage(for value: String) -> String? {
        let email = value.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !email.isEmpty else {
            return "Enter your email address."
        }

        guard !email.contains(where: { $0.isWhitespace }) else {
            return "Email must not contain spaces."
        }

        let parts = email.split(separator: "@", omittingEmptySubsequences: false)
        guard parts.count == 2,
              !parts[0].isEmpty,
              let domain = parts.last,
              domain.contains("."),
              !domain.hasPrefix("."),
              !domain.hasSuffix(".") else {
            return "Enter a valid email address."
        }

        return nil
    }
}
