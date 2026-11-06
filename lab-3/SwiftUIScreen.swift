import SwiftUI

struct SwiftUIScreen: View {
    @State private var studentName = ""
    @State private var result = "Your greeting will appear here."

    var body: some View {
        VStack(spacing: 20) {
            Text("Student Greeting")
                .font(.largeTitle)
                .bold()

            TextField("Enter your name", text: $studentName)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)

            Button("Generate Greeting") {
                let name = studentName.trimmingCharacters(
                    in: .whitespacesAndNewlines
                )

                if name.isEmpty {
                    result = "Please enter your name."
                } else {
                    result = "Hello, \(name)! Welcome to SwiftUI."
                }
            }
            .buttonStyle(.borderedProminent)

            Text(result)
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding()
        }
        .padding()
    }
}

#Preview {
    SwiftUIScreen()
}