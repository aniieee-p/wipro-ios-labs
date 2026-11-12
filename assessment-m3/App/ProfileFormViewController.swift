import UIKit

@MainActor
final class ProfileFormViewController: UIViewController, UITextFieldDelegate {
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    private let nameField = UITextField()
    private let emailField = UITextField()
    private let courseField = UITextField()
    private let nameError = Self.makeErrorLabel()
    private let emailError = Self.makeErrorLabel()
    private let courseError = Self.makeErrorLabel()
    private let statusLabel = UILabel()
    private let submitButton = UIButton(type: .system)
    private var errors: [ProfileField: UILabel] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Your Profile"
        view.backgroundColor = .systemBackground
        configureFields()
        configureLayout()
        configureKeyboardDismissal()
    }

    private func configureFields() {
        configure(nameField, placeholder: "Full name", accessibility: "Full name")
        nameField.textContentType = .name
        nameField.autocapitalizationType = .words
        nameField.returnKeyType = .next

        configure(emailField, placeholder: "name@example.com", accessibility: "Email address")
        emailField.textContentType = .emailAddress
        emailField.keyboardType = .emailAddress
        emailField.autocapitalizationType = .none
        emailField.autocorrectionType = .no
        emailField.returnKeyType = .next

        configure(courseField, placeholder: "Course name", accessibility: "Course name")
        courseField.autocapitalizationType = .words
        courseField.returnKeyType = .done

        errors = [.name: nameError, .email: emailError, .course: courseError]
        statusLabel.numberOfLines = 0
        statusLabel.textAlignment = .center
        statusLabel.font = .preferredFont(forTextStyle: .body)
        statusLabel.adjustsFontForContentSizeCategory = true
        statusLabel.accessibilityIdentifier = "profileStatus"

        var configuration = UIButton.Configuration.filled()
        configuration.title = "Continue to directory"
        submitButton.configuration = configuration
        submitButton.accessibilityIdentifier = "profileContinue"
        submitButton.addTarget(self, action: #selector(submit), for: .touchUpInside)
    }

    private func configure(_ field: UITextField, placeholder: String, accessibility: String) {
        field.placeholder = placeholder
        field.borderStyle = .roundedRect
        field.font = .preferredFont(forTextStyle: .body)
        field.adjustsFontForContentSizeCategory = true
        field.clearButtonMode = .whileEditing
        field.accessibilityLabel = accessibility
        field.delegate = self
        field.heightAnchor.constraint(greaterThanOrEqualToConstant: 44).isActive = true
    }

    private func configureLayout() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 12

        let heading = UILabel()
        heading.text = "Create your profile"
        heading.font = .preferredFont(forTextStyle: .largeTitle)
        heading.adjustsFontForContentSizeCategory = true
        heading.numberOfLines = 0
        heading.textAlignment = .center

        let description = UILabel()
        description.text = "Enter your name, email, and course to browse the directory."
        description.font = .preferredFont(forTextStyle: .body)
        description.textColor = .secondaryLabel
        description.numberOfLines = 0
        description.textAlignment = .center

        stackView.addArrangedSubview(heading)
        stackView.addArrangedSubview(description)
        stackView.addArrangedSubview(fieldGroup(title: "Full name", field: nameField, error: nameError))
        stackView.addArrangedSubview(fieldGroup(title: "Email address", field: emailField, error: emailError))
        stackView.addArrangedSubview(fieldGroup(title: "Course", field: courseField, error: courseError))
        stackView.addArrangedSubview(submitButton)
        stackView.addArrangedSubview(statusLabel)

        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor, constant: -24),
            stackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 36),
            stackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: -36),
            submitButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 48)
        ])
    }

    private func fieldGroup(title: String, field: UITextField, error: UILabel) -> UIStackView {
        let label = UILabel()
        label.text = title
        label.font = .preferredFont(forTextStyle: .headline)
        label.adjustsFontForContentSizeCategory = true
        let group = UIStackView(arrangedSubviews: [label, field, error])
        group.axis = .vertical
        group.spacing = 6
        return group
    }

    private static func makeErrorLabel() -> UILabel {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .footnote)
        label.textColor = .systemRed
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }

    private func configureKeyboardDismissal() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    @objc private func submit() {
        view.endEditing(true)
        let input = ProfileFormInput(
            name: nameField.text ?? "",
            email: emailField.text ?? "",
            course: courseField.text ?? ""
        )
        let result = ProfileFormValidator.validate(input)
        for (field, label) in errors {
            label.text = result.fields[field]
            label.isHidden = result.fields[field] == nil
        }

        guard result.isEmpty else {
            statusLabel.text = "Please correct the highlighted fields."
            statusLabel.textColor = .systemRed
            UIAccessibility.post(notification: .announcement, argument: statusLabel.text)
            return
        }

        let directory = DirectoryListViewController(profile: input)
        navigationController?.pushViewController(directory, animated: true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nameField: emailField.becomeFirstResponder()
        case emailField: courseField.becomeFirstResponder()
        default: submit()
        }
        return true
    }
}
