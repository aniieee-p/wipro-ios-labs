import UIKit

class UIKitScreen: UIViewController {

    private let titleLabel = UILabel()
    private let nameTextField = UITextField()
    private let greetingButton = UIButton(type: .system)
    private let resultLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        setupUI()
    }

    private func setupUI() {
        titleLabel.text = "Student Greeting"
        titleLabel.font = .boldSystemFont(ofSize: 28)
        titleLabel.textAlignment = .center

        nameTextField.placeholder = "Enter your name"
        nameTextField.borderStyle = .roundedRect

        greetingButton.setTitle("Generate Greeting", for: .normal)
        greetingButton.setTitleColor(.white, for: .normal)
        greetingButton.backgroundColor = .systemBlue
        greetingButton.layer.cornerRadius = 8
        greetingButton.addTarget(
            self,
            action: #selector(generateGreeting),
            for: .touchUpInside
        )

        resultLabel.text = "Your greeting will appear here."
        resultLabel.textAlignment = .center
        resultLabel.numberOfLines = 0

        let stack = UIStackView(
            arrangedSubviews: [
                titleLabel,
                nameTextField,
                greetingButton,
                resultLabel
            ]
        )

        stack.axis = .vertical
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: 24
            ),
            stack.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: -24
            ),
            stack.centerYAnchor.constraint(
                equalTo: view.centerYAnchor
            ),
            greetingButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    @objc private func generateGreeting() {
        let name = nameTextField.text?
            .trimmingCharacters(in: .whitespacesAndNewlines) ?? ""

        if name.isEmpty {
            resultLabel.text = "Please enter your name."
        } else {
            resultLabel.text = "Hello, \(name)! Welcome to UIKit."
        }
    }
}
