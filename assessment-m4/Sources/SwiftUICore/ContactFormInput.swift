import Foundation

// The raw text values typed into the contact form
public struct ContactFormInput: Equatable {
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

// Fields that can have a validation error
public enum ContactField: String, CaseIterable, Equatable {
    case name
    case email
    case phone
    case message
}

// Holds the validation errors after a form submission
public struct ContactFormErrors: Equatable {
    public let fields: [ContactField: String]
    public var isEmpty: Bool { return fields.isEmpty }

    public init(fields: [ContactField: String] = [:]) {
        self.fields = fields
    }
}

public enum ContactFormValidator {
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
            errors[.phone] = "Enter a valid phone number."
        }

        if input.message.isEmpty {
            errors[.message] = "Message is required."
        } else if input.message.count < 10 {
            errors[.message] = "Message must be at least 10 characters."
        }

        return ContactFormErrors(fields: errors)
    }

    private static func isValidEmail(_ email: String) -> Bool {
        let parts = email.split(separator: "@")
        if parts.count != 2 { return false }
        let local = String(parts[0])
        let domain = String(parts[1])
        return !local.isEmpty && domain.contains(".")
    }

    private static func isValidPhone(_ phone: String) -> Bool {
        var digitCount = 0
        for char in phone {
            if char.isNumber {
                digitCount += 1
            } else if char == " " || char == "+" || char == "-" || char == "(" || char == ")" {
                // allowed characters
            } else {
                return false
            }
        }
        return digitCount >= 7 && digitCount <= 15
    }
}
