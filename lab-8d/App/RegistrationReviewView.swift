import EventRegistrationCore
import SwiftUI

struct RegistrationReviewView: View {
    @Environment(\.dismiss) private var dismiss

    let registration: RegistrationFormData
    let onConfirm: () -> Void

    var body: some View {
        NavigationStack {
            Form {
                Section("Attendee") {
                    LabeledContent("Name", value: registration.fullName.trimmingCharacters(in: .whitespacesAndNewlines))
                    LabeledContent("Email", value: registration.email.trimmingCharacters(in: .whitespacesAndNewlines))
                }

                Section("Ticket") {
                    LabeledContent("Type", value: registration.ticketType?.rawValue ?? "Not selected")
                }

                Section("Preferences") {
                    LabeledContent(
                        "Accessibility support",
                        value: registration.needsAccessibilitySupport ? "Requested" : "Not requested"
                    )
                    if !registration.notes.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                        Text(registration.notes)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }

                Section {
                    Button("Confirm registration", action: onConfirm)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .accessibilityIdentifier("registration.confirm")
                }
            }
            .navigationTitle("Review")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Edit") {
                        dismiss()
                    }
                }
            }
        }
    }
}
