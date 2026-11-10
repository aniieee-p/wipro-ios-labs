import DirectoryCore
import SwiftUI

@main
struct Lab6App: App {
    var body: some Scene {
        WindowGroup {
            DirectoryScreen()
        }
    }
}

@MainActor
private struct DirectoryScreen: View {
    @StateObject private var model = DirectoryViewModel(
        service: UserDirectoryService(transport: URLSessionDirectoryTransport())
    )

    var body: some View {
        NavigationStack {
            content
                .navigationTitle("People Directory")
                .searchable(text: $model.searchText, prompt: "Search people")
                .toolbar {
                    if case .success = model.state {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button("Refresh", systemImage: "arrow.clockwise") {
                                model.load()
                            }
                            .disabled(isLoading)
                        }
                    }
                }
                .task {
                    if case .idle = model.state {
                        model.load()
                    }
                }
        }
    }

    @ViewBuilder
    private var content: some View {
        switch model.state {
        case .idle, .loading:
            VStack(spacing: 16) {
                ProgressView("Loading people…")
                Button("Cancel", role: .destructive) {
                    model.cancel()
                }
                .buttonStyle(.bordered)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        case .success:
            if model.visibleUsers.isEmpty {
                ContentUnavailableView.search(text: model.searchText)
            } else {
                List(model.visibleUsers) { user in
                    NavigationLink(value: user) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(user.name)
                                .font(.headline)
                            Text(user.email)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                            Text(user.company.name)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                .navigationDestination(for: DirectoryUser.self) { user in
                    UserDetailView(user: user)
                }
            }
        case .empty:
            ContentUnavailableView(
                "No People Found",
                systemImage: "person.3",
                description: Text("The server returned an empty directory.")
            )
            .overlay(alignment: .bottom) {
                retryButton
            }
        case .failure(let message):
            ContentUnavailableView(
                "Couldn’t Load Directory",
                systemImage: "wifi.exclamationmark",
                description: Text(message)
            )
            .overlay(alignment: .bottom) {
                retryButton
            }
        case .cancelled:
            ContentUnavailableView(
                "Request Cancelled",
                systemImage: "xmark.circle",
                description: Text("The directory request was cancelled.")
            )
            .overlay(alignment: .bottom) {
                retryButton
            }
        }
    }

    private var retryButton: some View {
        Button("Retry", systemImage: "arrow.clockwise") {
            model.load()
        }
        .buttonStyle(.borderedProminent)
        .padding(.bottom, 24)
    }

    private var isLoading: Bool {
        if case .loading = model.state { return true }
        return false
    }
}

private struct UserDetailView: View {
    let user: DirectoryUser

    var body: some View {
        List {
            Section("Contact") {
                LabeledContent("Email", value: user.email)
                LabeledContent("Phone", value: user.phone)
                LabeledContent("Website", value: user.website)
            }
            Section("Address") {
                LabeledContent("Street", value: "\(user.address.street), \(user.address.suite)")
                LabeledContent("City", value: user.address.city)
                LabeledContent("ZIP code", value: user.address.zipcode)
            }
            Section("Company") {
                LabeledContent("Name", value: user.company.name)
            }
        }
        .navigationTitle(user.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
