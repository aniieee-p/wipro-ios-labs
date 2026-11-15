import Foundation

// Book is the data model for a single item in our reading list.
//
// Identifiable  – gives every Book a unique `id` so List can track rows.
// Hashable      – required by NavigationLink(value:) so SwiftUI can
//                 compare values when managing the navigation stack.

struct Book: Identifiable, Hashable {
    let id: String
    let title: String
    let author: String
    let genre: String
    let year: Int
    let synopsis: String
}

// Sample data used by the list screen.
extension Book {
    static let samples: [Book] = [
        Book(id: "swift-prog",     title: "Swift Programming",        author: "Matt Neuburg",       genre: "Technology",          year: 2023, synopsis: "A thorough tour of Swift, from playgrounds to advanced generics."),
        Book(id: "clean-code",     title: "Clean Code",               author: "Robert C. Martin",   genre: "Software Engineering", year: 2008, synopsis: "Practical guidance on writing readable, maintainable code."),
        Book(id: "pragmatic",      title: "The Pragmatic Programmer",  author: "Hunt & Thomas",      genre: "Software Engineering", year: 2019, synopsis: "Career advice for professional developers, from DRY to tracer bullets."),
        Book(id: "swiftui-mastery",title: "SwiftUI Mastery",          author: "Karin Prater",       genre: "Technology",          year: 2022, synopsis: "Deep dives into layout, state management, and animations in SwiftUI."),
        Book(id: "atomic-habits",  title: "Atomic Habits",            author: "James Clear",        genre: "Self-Help",           year: 2018, synopsis: "A framework for building good habits through small changes."),
        Book(id: "sapiens",        title: "Sapiens",                  author: "Yuval Noah Harari",  genre: "History",             year: 2011, synopsis: "A sweeping narrative of human history from the Stone Age to now."),
        Book(id: "thinking-fast",  title: "Thinking, Fast and Slow",  author: "Daniel Kahneman",    genre: "Psychology",          year: 2011, synopsis: "How two systems of thought shape our decisions and judgements."),
        Book(id: "zero-to-one",    title: "Zero to One",              author: "Peter Thiel",        genre: "Business",            year: 2014, synopsis: "Notes on start-ups and how to build companies that create new things."),
    ]
}
