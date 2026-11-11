import UIKit

@MainActor
final class ProfileFormViewController: UIViewController, UITextFieldDelegate {
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let stackView = UIStackView()

    private let nameField = UITextField()
    private let emailField = UITextField()
    private let courseField = UITextField()
    private let nameError = Self.makeErrorLabel()
    private let emailError = Self.makeErrorLabel()
    private let courseError = Self.makeErrorLabel()
    private let statusLabel = UILabel()
    private let submitButton = UIButton(type: .system)
    private var errorLabels: [ProfileField: UILabel] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        view.backgroundColor = .systemBackground
        configureFields()
        configureLayout()
        configureKeyboardDismissal()
    }

    private func configureFields() {
        nameField.placeholder = "Full name"
        nameField.textContentType = .name
        nameField.autocapitalizationType = .words
        nameField.returnKeyType = .next
        nameField.accessibilityLabel = "Full name"
        nameField.accessibilityIdentifier = "profileName"
        nameField.delegate = self

        emailField.placeholder = "name@example.com"
        emailField.keyboardType = .emailAddress
        emailField.textContentType = .emailAddress
        emailField.autocapitalizationType = .none
        emailField.autocorrectionType = .no
        emailField.returnKeyType = .next
        emailField.accessibilityLabel = "Email address"
        emailField.accessibilityIdentifier = "profileEmail"
        emailField.delegate = self

        courseField.placeholder = "Course name"
        courseField.textContentType = .none
        courseField.autocapitalizationType = .words
        courseField.returnKeyType = .done
        courseField.accessibilityLabel = "Course name"
        courseField.accessibilityIdentifier = "profileCourse"
        courseField.delegate = self

        for field in [nameField, emailField, courseField] {
            field.borderStyle = .roundedRect
            field.font = .preferredFont(forTextStyle: .body)
            field.adjustsFontForContentSizeCategory = true
            field.clearButtonMode = .whileEditing
            field.heightAnchor.constraint(greaterThanOrEqualToConstant: 44).isActive = true
        }

        errorLabels = [.name: nameError, .email: emailError, .course: courseError]
        statusLabel.font = .preferredFont(forTextStyle: .body)
        statusLabel.adjustsFontForContentSizeCategory = true
        statusLabel.numberOfLines = 0
        statusLabel.textAlignment = .center
        statusLabel.accessibilityIdentifier = "profileStatus"

        var configuration = UIButton.Configuration.filled()
        configuration.title = "Submit profile"
        submitButton.configuration = configuration
        submitButton.titleLabel?.font = .preferredFont(forTextStyle: .headline)
        submitButton.titleLabel?.adjustsFontForContentSizeCategory = true
        submitButton.accessibilityIdentifier = "profileSubmit"
        submitButton.addTarget(self, action: #selector(submitProfile), for: .touchUpInside)
    }

    private func configureLayout() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 12

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)

        let heading = UILabel()
        heading.text = "Create your profile"
        heading.font = .preferredFont(forTextStyle: .largeTitle)
        heading.adjustsFontForContentSizeCategory = true
        heading.numberOfLines = 0
        heading.textAlignment = .center

        let description = UILabel()
        description.text = "Enter your details to get started."
        description.font = .preferredFont(forTextStyle: .body)
        description.adjustsFontForContentSizeCategory = true
        description.textColor = .secondaryLabel
        description.numberOfLines = 0
        description.textAlignment = .center

        let topSpacer = UIView()
        topSpacer.setContentHuggingPriority(.defaultLow, for: .vertical)
        let bottomSpacer = UIView()
        bottomSpacer.setContentHuggingPriority(.defaultLow, for: .vertical)
        stackView.addArrangedSubview(topSpacer)
        stackView.addArrangedSubview(heading)
        stackView.addArrangedSubview(description)
        stackView.addArrangedSubview(fieldGroup(title: "Full name", field: nameField, error: nameError))
        stackView.addArrangedSubview(fieldGroup(title: "Email address", field: emailField, error: emailError))
        stackView.addArrangedSubview(fieldGroup(title: "Course", field: courseField, error: courseError))
        stackView.addArrangedSubview(submitButton)
        stackView.addArrangedSubview(statusLabel)
        stackView.addArrangedSubview(bottomSpacer)

        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor),

            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),

            stackView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            submitButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 48),
            topSpacer.heightAnchor.constraint(equalTo: bottomSpacer.heightAnchor)
        ])

        contentView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24)
    }

    private func fieldGroup(title: String, field: UITextField, error: UILabel) -> UIStackView {
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .preferredFont(forTextStyle: .headline)
        titleLabel.adjustsFontForContentSizeCategory = true
        let group = UIStackView(arrangedSubviews: [titleLabel, field, error])
        group.axis = .vertical
        group.spacing = 6
        return group
    }

    private static func makeErrorLabel() -> UILabel {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .footnote)
        label.adjustsFontForContentSizeCategory = true
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

    @objc private func submitProfile() {
        view.endEditing(true)
        let errors = ProfileFormValidator.validate(
            ProfileFormInput(
                name: nameField.text ?? "",
                email: emailField.text ?? "",
                course: courseField.text ?? ""
            )
        )

        for (field, label) in errorLabels {
            label.text = errors.fields[field]
            label.isHidden = errors.fields[field] == nil
        }

        guard errors.isEmpty else {
            statusLabel.text = "Please correct the highlighted fields."
            statusLabel.textColor = .systemRed
            UIAccessibility.post(notification: .announcement, argument: "Please correct the highlighted fields.")
            return
        }

        statusLabel.text = "Profile submitted successfully."
        statusLabel.textColor = .systemGreen
        UIAccessibility.post(notification: .announcement, argument: "Profile submitted successfully.")
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nameField:
            emailField.becomeFirstResponder()
        case emailField:
            courseField.becomeFirstResponder()
        default:
            submitProfile()
        }
        return true
    }
}
