import EventRegistrationCore
import SwiftUI

struct EventRegistrationView: View {
    @State private var registration = RegistrationFormData()
    @State private var isReviewPresented = false
    @State private var didRegister = false

    private var validation: RegistrationValidation {
        registration.validation
    }

    var body: some View {
        NavigationStack {
            Form {
                eventSection
                attendeeSection
                ticketSection
                preferencesSection
                termsSection
                submitSection
            }
            .scrollContentBackground(.hidden)
            .background(Color(uiColor: .systemGroupedBackground))
            .navigationTitle("Event Registration")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $isReviewPresented) {
                RegistrationReviewView(registration: registration) {
                    isReviewPresented = false
                    didRegister = true
                }
            }
            .alert("You're registered!", isPresented: $didRegister) {
                Button("Done", role: .cancel) {}
            } message: {
                Text("A confirmation will be sent to \(registration.email.trimmingCharacters(in: .whitespacesAndNewlines)).")
            }
        }
    }

    private var eventSection: some View {
        Section {
            VStack(alignment: .leading, spacing: 8) {
                Label("Swift Summit 2026", systemImage: "sparkles")
                    .font(.title2.bold())
                    .fixedSize(horizontal: false, vertical: true)
                Text("A day of ideas, workshops, and community.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
                Label("Saturday, November 21 · 9:00 AM", systemImage: "calendar")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(.vertical, 8)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    private var attendeeSection: some View {
        Section("Attendee") {
            VStack(alignment: .leading, spacing: 6) {
                TextField("Full name", text: $registration.fullName)
                    .textContentType(.name)
                    .textInputAutocapitalization(.words)
                    .autocorrectionDisabled()
                    .accessibilityIdentifier("registration.fullName")
                if let message = validation.nameMessage {
                    ValidationMessage(text: message)
                }
            }
            .padding(.vertical, 3)

            VStack(alignment: .leading, spacing: 6) {
                TextField("Email address", text: $registration.email)
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .accessibilityIdentifier("registration.email")
                if let message = validation.emailMessage {
                    ValidationMessage(text: message)
                }
            }
            .padding(.vertical, 3)
        }
    }

    private var ticketSection: some View {
        Section("Ticket") {
            Picker("Ticket type", selection: $registration.ticketType) {
                Text("Choose a ticket")
                    .tag(nil as TicketType?)
                ForEach(TicketType.allCases) { ticket in
                    Text(ticket.rawValue)
                        .tag(Optional(ticket))
                }
            }
            .accessibilityIdentifier("registration.ticketType")

            if let message = validation.ticketMessage {
                ValidationMessage(text: message)
            }
        }
    }

    private var preferencesSection: some View {
        Section {
            Toggle(
                "I need accessibility support",
                isOn: $registration.needsAccessibilitySupport
            )
            .accessibilityIdentifier("registration.accessibilitySupport")

            VStack(alignment: .leading, spacing: 6) {
                Text("Additional notes (optional)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                TextField(
                    "Share access or dietary requests",
                    text: $registration.notes,
                    axis: .vertical
                )
                .lineLimit(3...7)
                .textInputAutocapitalization(.sentences)
                .accessibilityIdentifier("registration.notes")
            }
            .padding(.vertical, 4)
        } header: {
            Text("Preferences")
        } footer: {
            Text("Notes are optional. Long requests remain scrollable within the form.")
        }
    }

    private var termsSection: some View {
        Section {
            Toggle("I agree to the event terms", isOn: $registration.acceptsTerms)
                .accessibilityIdentifier("registration.acceptsTerms")
            if let message = validation.termsMessage {
                ValidationMessage(text: message)
            }
        } header: {
            Text("Before you continue")
        }
    }

    private var submitSection: some View {
        Section {
            Button {
                isReviewPresented = true
            } label: {
                HStack(spacing: 10) {
                    Spacer(minLength: 0)
                    Text("Review registration")
                    Image(systemName: "arrow.right")
                    Spacer(minLength: 0)
                }
                .frame(minHeight: 44)
                .contentShape(Rectangle())
            }
            .disabled(!validation.isValid)
            .accessibilityIdentifier("registration.review")

            if !validation.isValid {
                Text("Complete the required fields above to continue.")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }
}

#Preview {
    EventRegistrationView()
}
