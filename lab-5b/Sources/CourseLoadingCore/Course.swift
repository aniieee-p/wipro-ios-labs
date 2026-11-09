import Foundation

public struct Course: Identifiable, Equatable, Sendable {
    public let id: String
    public let title: String
    public let instructor: String

    public init(id: String, title: String, instructor: String) {
        self.id = id
        self.title = title
        self.instructor = instructor
    }
}
