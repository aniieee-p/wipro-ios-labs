import Foundation

public struct ProfileFormInput: Equatable, Sendable {
    public let name: String
    public let email: String
    public let course: String

    public init(name: String, email: String, course: String) {
        self.name = name
        self.email = email
        self.course = course
    }
}

public enum ProfileField: String, CaseIterable, Equatable, Sendable {
    case name
    case email
    case course
}

public struct ProfileFormErrors: Equatable, Sendable {
    public let fields: [ProfileField: String]

    public init(fields: [ProfileField: String]) {
        self.fields = fields
    }

    public var isEmpty: Bool { fields.isEmpty }
}

public enum ProfileFormValidator {
    public static func validate(_ input: ProfileFormInput) -> ProfileFormErrors {
        var errors: [ProfileField: String] = [:]
        let name = input.name.trimmingCharacters(in: .whitespacesAndNewlines)
        let email = input.email.trimmingCharacters(in: .whitespacesAndNewlines)
        let course = input.course.trimmingCharacters(in: .whitespacesAndNewlines)

        if name.isEmpty {
            errors[.name] = "Enter your full name."
        }

        if email.isEmpty {
            errors[.email] = "Enter your email address."
        } else if !isValidEmail(email) {
            errors[.email] = "Enter a valid email address."
        }

        if course.isEmpty {
            errors[.course] = "Enter your course name."
        }

        return ProfileFormErrors(fields: errors)
    }

    private static func isValidEmail(_ email: String) -> Bool {
        let parts = email.split(separator: "@", omittingEmptySubsequences: false)
        guard parts.count == 2, !parts[0].isEmpty else { return false }
        let domainParts = parts[1].split(separator: ".", omittingEmptySubsequences: false)
        return domainParts.count >= 2 && domainParts.allSatisfy { !$0.isEmpty }
    }
}
