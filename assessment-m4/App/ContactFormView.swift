import SwiftUI

struct ContactFormView: View {

    // One @State variable per field — updated as the user types.
    @State private var name    = ""
    @State private var email   = ""
    @State private var phone   = ""
    @State private var message = ""

    // Validation error strings — nil means no error for that field.
    @State private var nameError:    String? = nil
    @State private var emailError:   String? = nil
    @State private var phoneError:   String? = nil
    @State private var messageError: String? = nil

    // Controls the loading spinner on the button.
    @State private var isSubmitting = false

    // Shown after a successful submission.
    @State private var didSubmit = false

    // Shown when the simulated server call fails.
    @State private var serverError: String? = nil

    // @FocusState tracks which field has keyboard focus.
    // Setting it to nil dismisses the keyboard.
    @FocusState private var focusedField: Field?

    enum Field { case name, email, phone, message }

    var body: some View {
        Form {
            if didSubmit {
                successSection
            } else {
                fieldsSection
                submitSection
            }
        }
        .navigationTitle("Contact Us")
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Sections

    private var fieldsSection: some View {
        Section("Your details") {

            // Name
            VStack(alignment: .leading, spacing: 4) {
                TextField("Full name", text: $name)
                    .focused($focusedField, equals: .name)
                    .textContentType(.name)
                if let error = nameError {
                    Text(error).font(.caption).foregroundStyle(.red)
                }
            }

            // Email
            VStack(alignment: .leading, spacing: 4) {
                TextField("Email address", text: $email)
                    .focused($focusedField, equals: .email)
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                if let error = emailError {
                    Text(error).font(.caption).foregroundStyle(.red)
                }
            }

            // Phone
            VStack(alignment: .leading, spacing: 4) {
                TextField("Phone number", text: $phone)
                    .focused($focusedField, equals: .phone)
                    .textContentType(.telephoneNumber)
                    .keyboardType(.phonePad)
                if let error = phoneError {
                    Text(error).font(.caption).foregroundStyle(.red)
                }
            }

            // Message
            VStack(alignment: .leading, spacing: 4) {
                TextField("Message", text: $message, axis: .vertical)
                    .focused($focusedField, equals: .message)
                    .lineLimit(3...6)
                if let error = messageError {
                    Text(error).font(.caption).foregroundStyle(.red)
                }
            }
        }
    }

    private var submitSection: some View {
        Section {
            // Server-level error banner (shown above the button).
            if let error = serverError {
                Label(error, systemImage: "exclamationmark.triangle")
                    .foregroundStyle(.red)
                    .font(.subheadline)
            }

            Button(action: submit) {
                if isSubmitting {
                    // Loading state: replace button label with a spinner.
                    HStack {
                        ProgressView()
                        Text("Sending…")
                    }
                    .frame(maxWidth: .infinity)
                } else {
                    Text("Submit")
                        .frame(maxWidth: .infinity)
                        .bold()
                }
            }
            .disabled(isSubmitting)
        }
    }

    private var successSection: some View {
        Section {
            VStack(spacing: 16) {
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 56))
                    .foregroundStyle(.green)
                Text("Message sent!")
                    .font(.title3.bold())
                Text("Thanks \(firstName). We'll be in touch soon.")
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                Button("Send another message") {
                    resetForm()
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
        }
    }

    // MARK: - Validation

    // Returns true if all fields are valid, false otherwise.
    // Sets the error @State variables as a side effect.
    private func validate() -> Bool {
        // Trim whitespace before checking.
        let trimmedName    = name.trimmingCharacters(in: .whitespaces)
        let trimmedEmail   = email.trimmingCharacters(in: .whitespaces)
        let trimmedPhone   = phone.trimmingCharacters(in: .whitespaces)
        let trimmedMessage = message.trimmingCharacters(in: .whitespaces)

        nameError    = trimmedName.isEmpty    ? "Name is required."              : nil
        messageError = trimmedMessage.isEmpty ? "Message is required."           : nil
        phoneError   = trimmedPhone.isEmpty   ? "Phone number is required."      : nil

        if trimmedEmail.isEmpty {
            emailError = "Email address is required."
        } else if !trimmedEmail.contains("@") || !trimmedEmail.contains(".") {
            emailError = "Enter a valid email address."
        } else {
            emailError = nil
        }

        return nameError == nil && emailError == nil &&
               phoneError == nil && messageError == nil
    }

    // MARK: - Submit action

    private func submit() {
        // Dismiss keyboard.
        focusedField = nil
        serverError  = nil

        guard validate() else { return }

        isSubmitting = true

        // Task runs async code without blocking the main thread.
        Task {
            // Simulate a 1.5 second network call.
            try? await Task.sleep(for: .seconds(1.5))

            // Use "fail@test.com" to trigger the error path
            // so you can demonstrate error handling without a real server.
            if email.lowercased() == "fail@test.com" {
                serverError  = "Server error. Please try again."
                isSubmitting = false
            } else {
                isSubmitting = false
                didSubmit    = true
            }
        }
    }

    // MARK: - Helpers

    private var firstName: String {
        name.trimmingCharacters(in: .whitespaces)
            .split(separator: " ")
            .first
            .map(String.init) ?? name
    }

    private func resetForm() {
        name         = ""
        email        = ""
        phone        = ""
        message      = ""
        nameError    = nil
        emailError   = nil
        phoneError   = nil
        messageError = nil
        serverError  = nil
        didSubmit    = false
    }
}

#Preview {
    NavigationStack {
        ContactFormView()
    }
}
