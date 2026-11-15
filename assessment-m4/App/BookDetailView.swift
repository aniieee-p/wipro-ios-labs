import SwiftUI

struct BookDetailView: View {
    let book: Book

    // @Binding means this view does NOT own the data.
    // It reads and writes the Set<String> that BookListView owns via @State.
    // When this view inserts or removes an id, BookListView sees the change
    // immediately — there is only one copy of the data.
    @Binding var favourites: Set<String>

    private var isFavourite: Bool {
        favourites.contains(book.id)
    }

    var body: some View {
        Form {
            Section("About") {
                LabeledContent("Author", value: book.author)
                LabeledContent("Genre",  value: book.genre)
                LabeledContent("Year",   value: String(book.year))
            }

            Section("Synopsis") {
                Text(book.synopsis)
            }

            Section {
                Button {
                    // Insert or remove the book's id from the shared Set.
                    if isFavourite {
                        favourites.remove(book.id)
                    } else {
                        favourites.insert(book.id)
                    }
                } label: {
                    Label(
                        isFavourite ? "Remove from Favourites" : "Add to Favourites",
                        systemImage: isFavourite ? "heart.slash" : "heart"
                    )
                    .foregroundStyle(isFavourite ? .secondary : .pink)
                }
            }
        }
        .navigationTitle(book.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        // .constant() creates a fixed Binding for preview purposes.
        BookDetailView(book: Book.samples[0], favourites: .constant([]))
    }
}
