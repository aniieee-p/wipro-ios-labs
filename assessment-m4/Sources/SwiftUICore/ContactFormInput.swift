import Foundation

// MARK: - Contact form model (R3)

/// The raw text values typed into the registration form.
public struct ContactFormInput: Equatable, Sendable {
    public let name: String
    public let email: String
    public let phone: String
    public let message: String

    public init(name: String, email: String, phone: String, message: String) {
        self.name    = name.trimmingCharacters(in: .whitespacesAndNewlines)
        self.email   = email.trimmingCharacters(in: .whitespacesAndNewlines)
        self.phone   = phone.trimmingCharacters(in: .whitespacesAndNewlines)
        self.message = message.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

/// The fields that can carry a validation error.
public enum ContactField: String, CaseIterable, Equatable, Sendable {
    case name
    case email
    case phone
    case message
}

/// The set of validation errors for a submission attempt.
public struct ContactFormErrors: Equatable, Sendable {
    public let fields: [ContactField: String]
    public var isEmpty: Bool { fields.isEmpty }

    public init(fields: [ContactField: String] = [:]) {
        self.fields = fields
    }
}

// MARK: - Validator

public enum ContactFormValidator {
    /// Validates `input` and returns any field-level error messages.
    public static func validate(_ input: ContactFormInput) -> ContactFormErrors {
        var errors: [ContactField: String] = [:]

        if input.name.isEmpty {
            errors[.name] = "Full name is required."
        } else if input.name.count < 2 {
            errors[.name] = "Name must be at least 2 characters."
        }

        if input.email.isEmpty {
            errors[.email] = "Email address is required."
        } else if !isValidEmail(input.email) {
            errors[.email] = "Enter a valid email address."
        }

        if input.phone.isEmpty {
            errors[.phone] = "Phone number is required."
        } else if !isValidPhone(input.phone) {
            errors[.phone] = "Enter a valid phone number (digits, spaces, +, -)."
        }

        if input.message.isEmpty {
            errors[.message] = "Message is required."
        } else if input.message.count < 10 {
            errors[.message] = "Message must be at least 10 characters."
        }

        return ContactFormErrors(fields: errors)
    }

    // MARK: Private helpers

    private static func isValidEmail(_ email: String) -> Bool {
        let parts = email.split(separator: "@", omittingEmptySubsequences: false)
        guard parts.count == 2, !parts[0].isEmpty else { return false }
        let domain = parts[1].split(separator: ".", omittingEmptySubsequences: false)
        return domain.count >= 2 && domain.allSatisfy { !$0.isEmpty }
    }

    private static func isValidPhone(_ phone: String) -> Bool {
        let allowed = CharacterSet.decimalDigits.union(CharacterSet(charactersIn: " +-()"))
        guard phone.unicodeScalars.allSatisfy({ allowed.contains($0) }) else { return false }
        let digits = phone.filter(\.isNumber)
        return digits.count >= 7 && digits.count <= 15
    }
}
