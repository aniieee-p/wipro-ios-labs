import ConfigurationAuditCore
import SwiftUI

private struct ConfigurationItem: Identifiable {
    let id: String
    let title: String
    let detail: String
}

struct ConfigurationChecklistView: View {
    @State private var checklist = AuditChecklist(
        itemIDs: ["target", "identity", "version", "deployment", "signing", "orientations", "privacy"]
    )

    private let items = [
        ConfigurationItem(id: "target", title: "Inspect app target", detail: "Confirm the application target and build phases."),
        ConfigurationItem(id: "identity", title: "Check bundle identifier", detail: "Use a unique reverse-DNS identifier for distribution."),
        ConfigurationItem(id: "version", title: "Check version and build", detail: "Verify the user-facing version and incrementing build number."),
        ConfigurationItem(id: "deployment", title: "Check deployment target", detail: "Confirm the minimum supported iOS version."),
        ConfigurationItem(id: "signing", title: "Review signing settings", detail: "Use the correct team and signing style; never commit certificates or keys."),
        ConfigurationItem(id: "orientations", title: "Check supported orientations", detail: "Match declared orientations to layouts the app supports."),
        ConfigurationItem(id: "privacy", title: "Review privacy descriptions", detail: "Add a clear purpose string only for permissions the app actually requests.")
    ]

    var body: some View {
        NavigationStack {
            List {
                Section {
                    VStack(alignment: .leading, spacing: 10) {
                        Label("Configuration Audit", systemImage: "checkmark.shield")
                            .font(.title2.bold())
                            .fixedSize(horizontal: false, vertical: true)
                        Text("A local checklist for reviewing iOS app settings. It does not request device permissions or collect personal data.")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .fixedSize(horizontal: false, vertical: true)
                        ProgressView(value: checklist.completionFraction)
                        Text("\(checklist.completedItemIDs.count) of \(items.count) checks complete")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.vertical, 8)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }

                Section("Project review") {
                    ForEach(items) { item in
                        Toggle(isOn: binding(for: item)) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(item.title)
                                    .font(.body.weight(.medium))
                                    .fixedSize(horizontal: false, vertical: true)
                                Text(item.detail)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            .padding(.vertical, 5)
                        }
                        .accessibilityIdentifier("audit.\(item.id)")
                    }
                }

                Section {
                    Label("No permissions requested", systemImage: "hand.raised")
                        .foregroundStyle(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                } footer: {
                    Text("This checklist feature works entirely on screen. It does not use photos, location, camera, contacts, or network access.")
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            .listStyle(.insetGrouped)
            .scrollContentBackground(.hidden)
            .background(Color(uiColor: .systemGroupedBackground))
            .navigationTitle("Lab 9")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    private func binding(for item: ConfigurationItem) -> Binding<Bool> {
        Binding(
            get: { checklist.isCompleted(item.id) },
            set: { checklist.setCompleted($0, for: item.id) }
        )
    }
}

#Preview {
    ConfigurationChecklistView()
}
