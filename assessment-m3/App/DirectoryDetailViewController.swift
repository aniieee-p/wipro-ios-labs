import UIKit

@MainActor
final class DirectoryDetailViewController: UIViewController {
    private let user: DirectoryUser
    private let profile: ProfileFormInput

    init(user: DirectoryUser, profile: ProfileFormInput) {
        self.user = user
        self.profile = profile
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        return nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Person"
        view.backgroundColor = .systemBackground

        let greeting = UILabel()
        greeting.text = "Hello, \(profile.name)"
        greeting.font = .preferredFont(forTextStyle: .subheadline)
        greeting.textColor = .secondaryLabel

        let name = UILabel()
        name.text = user.name
        name.font = .preferredFont(forTextStyle: .largeTitle)
        name.adjustsFontForContentSizeCategory = true
        name.numberOfLines = 0

        let username = makeLabel(title: "Username", value: user.username)
        let email = makeLabel(title: "Email", value: user.email)
        let phone = makeLabel(title: "Phone", value: user.phone)
        let website = makeLabel(title: "Website", value: user.website)
        let company = makeLabel(title: "Company", value: user.company.name)
        let address = makeLabel(
            title: "Address",
            value: "\(user.address.street), \(user.address.suite)\n\(user.address.city), \(user.address.zipcode)"
        )

        let stack = UIStackView(arrangedSubviews: [
            greeting, name, username, email, phone, website, company, address
        ])
        stack.axis = .vertical
        stack.spacing = 18
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            stack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 28)
        ])
    }

    private func makeLabel(title: String, value: String) -> UILabel {
        let label = UILabel()
        label.text = "\(title): \(value)"
        label.font = .preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        return label
    }
}
