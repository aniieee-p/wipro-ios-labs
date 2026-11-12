import Foundation

public struct DirectoryUser: Codable, Equatable, Hashable, Identifiable, Sendable {
    public let id: Int
    public let name: String
    public let username: String
    public let email: String
    public let phone: String
    public let website: String
    public let address: Address
    public let company: Company

    public struct Address: Codable, Equatable, Hashable, Sendable {
        public let street: String
        public let suite: String
        public let city: String
        public let zipcode: String
    }

    public struct Company: Codable, Equatable, Hashable, Sendable {
        public let name: String
    }
}
