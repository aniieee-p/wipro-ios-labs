
import Foundation

// MARK: - Book model (R1 sample data for NavigationStack list-detail flow)

/// A single book in the reading list.
public struct Book: Equatable, Hashable, Identifiable, Sendable {
    public let id: String
    public let title: String
    public let author: String
    public let genre: String
    public let year: Int
    public let synopsis: String

    public init(
        id: String,
        title: String,
        author: String,
        genre: String,
        year: Int,
        synopsis: String
    ) {
        self.id = id
        self.title = title
        self.author = author
        self.genre = genre
        self.year = year
        self.synopsis = synopsis
    }

    /// Ten sample books used throughout the app.
    public static let samples: [Book] = [
        Book(
            id: "swift-prog",
            title: "Swift Programming",
            author: "Matt Neuburg",
            genre: "Technology",
            year: 2023,
            synopsis: "A thorough tour of the Swift language, from playgrounds to advanced generics."
        ),
        Book(
            id: "clean-code",
            title: "Clean Code",
            author: "Robert C. Martin",
            genre: "Software Engineering",
            year: 2008,
            synopsis: "Practical guidance on writing readable, maintainable code with real-world examples."
        ),
        Book(
            id: "pragmatic",
            title: "The Pragmatic Programmer",
            author: "Hunt & Thomas",
            genre: "Software Engineering",
            year: 2019,
            synopsis: "Career-spanning advice for professional developers, from DRY to tracer bullets."
        ),
        Book(
            id: "design-patterns",
            title: "Design Patterns",
            author: "Gang of Four",
            genre: "Software Engineering",
            year: 1994,
            synopsis: "The classic catalogue of 23 reusable object-oriented design patterns."
        ),
        Book(
            id: "swiftui-mastery",
            title: "SwiftUI Mastery",
            author: "Karin Prater",
            genre: "Technology",
            year: 2022,
            synopsis: "Deep dives into layout, state management, and custom animations in SwiftUI."
        ),
        Book(
            id: "atomic-habits",
            title: "Atomic Habits",
            author: "James Clear",
            genre: "Self-Help",
            year: 2018,
            synopsis: "A framework for building good habits and breaking bad ones through small changes."
        ),
        Book(
            id: "sapiens",
            title: "Sapiens",
            author: "Yuval Noah Harari",
            genre: "History",
            year: 2011,
            synopsis: "A sweeping narrative of human history from the Stone Age to the present."
        ),
        Book(
            id: "thinking-fast",
            title: "Thinking, Fast and Slow",
            author: "Daniel Kahneman",
            genre: "Psychology",
            year: 2011,
            synopsis: "How two systems of thought shape our decisions, judgments, and behaviour."
        ),
        Book(
            id: "mythical-man",
            title: "The Mythical Man-Month",
            author: "Fred Brooks",
            genre: "Software Engineering",
            year: 1975,
            synopsis: "Essays on software project management and why adding people delays late projects."
        ),
        Book(
            id: "zero-to-one",
            title: "Zero to One",
            author: "Peter Thiel",
            genre: "Business",
            year: 2014,
            synopsis: "Notes on start-ups and how to build companies that create new things."
        )
    ]
}
