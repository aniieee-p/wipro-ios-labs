import UIKit

@MainActor
final class LifecycleDetailViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        LifecycleLogStore.shared.record("Detail: viewDidLoad")
        title = "Lifecycle Detail"
        view.backgroundColor = .systemBackground

        let label = UILabel()
        label.text = "Tap Back to observe the settings screen appearing again."
        label.font = .preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        LifecycleLogStore.shared.record("Detail: viewWillAppear")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        LifecycleLogStore.shared.record("Detail: viewDidAppear")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        LifecycleLogStore.shared.record("Detail: viewWillDisappear")
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        LifecycleLogStore.shared.record("Detail: viewDidDisappear")
    }
}
