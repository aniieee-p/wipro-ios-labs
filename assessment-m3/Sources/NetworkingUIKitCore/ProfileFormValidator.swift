import Foundation

public struct ProfileFormInput: Equatable, Sendable {
    public let name: String
    public let email: String
    public let course: String

    public init(name: String, email: String, course: String) {
        self.name = name.trimmingCharacters(in: .whitespacesAndNewlines)
        self.email = email.trimmingCharacters(in: .whitespacesAndNewlines)
        self.course = course.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

public enum ProfileField: String, CaseIterable, Equatable, Sendable {
    case name
    case email
    case course
}

public struct ProfileFormErrors: Equatable, Sendable {
    public let fields: [ProfileField: String]
    public var isEmpty: Bool { fields.isEmpty }

    public init(fields: [ProfileField: String]) {
        self.fields = fields
    }
}

public enum ProfileFormValidator {
    public static func validate(_ input: ProfileFormInput) -> ProfileFormErrors {
        var errors: [ProfileField: String] = [:]
        if input.name.isEmpty {
            errors[.name] = "Enter your full name."
        }
        if input.email.isEmpty {
            errors[.email] = "Enter your email address."
        } else if !isValidEmail(input.email) {
            errors[.email] = "Enter a valid email address."
        }
        if input.course.isEmpty {
            errors[.course] = "Enter your course name."
        }
        return ProfileFormErrors(fields: errors)
    }

    private static func isValidEmail(_ email: String) -> Bool {
        let parts = email.split(separator: "@", omittingEmptySubsequences: false)
        guard parts.count == 2, !parts[0].isEmpty else { return false }
        let domain = parts[1].split(separator: ".", omittingEmptySubsequences: false)
        return domain.count >= 2 && domain.allSatisfy { !$0.isEmpty }
    }
}
