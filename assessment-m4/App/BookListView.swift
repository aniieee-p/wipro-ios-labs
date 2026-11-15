import SwiftUI

struct BookListView: View {
    // @State makes this view the owner of the favourites data.
    // Using a Set<String> of book IDs is the simplest approach —
    // a book is a favourite if its id is in this set.
    @State private var favourites: Set<String> = []

    var body: some View {
        NavigationStack {
            List(Book.samples) { book in
                NavigationLink(value: book) {
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(book.title)
                                .font(.headline)
                            Text(book.author)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                            Text("\(book.genre) · \(book.year)")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        .padding(.vertical, 4)

                        Spacer()

                        // Show a filled heart if this book is a favourite.
                        if favourites.contains(book.id) {
                            Image(systemName: "heart.fill")
                                .foregroundStyle(.pink)
                        }
                    }
                }
            }
            .navigationTitle("Reading List")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: ContactFormView()) {
                        Image(systemName: "envelope")
                    }
                }
            }
            // Pass $favourites (a Binding) so BookDetailView can read
            // and write the same Set that this view owns.
            .navigationDestination(for: Book.self) { book in
                BookDetailView(book: book, favourites: $favourites)
            }
        }
    }
}

#Preview {
    BookListView()
}
