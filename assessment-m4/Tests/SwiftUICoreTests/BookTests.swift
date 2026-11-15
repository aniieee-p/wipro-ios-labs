import XCTest
@testable import SwiftUICore

final class BookTests: XCTestCase {

    func testSampleDataContainsTenBooks() {
        XCTAssertEqual(Book.samples.count, 10)
    }

    func testAllSampleIDsAreUnique() {
        let ids = Book.samples.map(\.id)
        XCTAssertEqual(ids.count, Set(ids).count)
    }

    func testAllSampleBooksHaveNonEmptyFields() {
        for book in Book.samples {
            XCTAssertFalse(book.id.isEmpty,       "id empty for \(book.title)")
            XCTAssertFalse(book.title.isEmpty,     "title empty for id \(book.id)")
            XCTAssertFalse(book.author.isEmpty,    "author empty for \(book.title)")
            XCTAssertFalse(book.genre.isEmpty,     "genre empty for \(book.title)")
            XCTAssertFalse(book.synopsis.isEmpty,  "synopsis empty for \(book.title)")
            XCTAssertGreaterThan(book.year, 1900)
        }
    }

    func testBookEquality() {
        let a = Book(id: "x", title: "T", author: "A", genre: "G", year: 2020, synopsis: "S")
        let b = Book(id: "x", title: "T", author: "A", genre: "G", year: 2020, synopsis: "S")
        XCTAssertEqual(a, b)
    }

    func testBookHashability() {
        // Books can be used as dictionary keys and in sets.
        let set: Set<Book> = [Book.samples[0], Book.samples[1], Book.samples[0]]
        XCTAssertEqual(set.count, 2)
    }
}
