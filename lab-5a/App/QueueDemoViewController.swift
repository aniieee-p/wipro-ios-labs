import QueueDemoCore
import UIKit

@MainActor
final class QueueDemoViewController: UIViewController {
    private let coordinator = ParallelWorkCoordinator()
    private let titleLabel = UILabel()
    private let explanationLabel = UILabel()
    private let runButton = UIButton(type: .system)
    private let activityIndicator = UIActivityIndicatorView(style: .medium)
    private let statusLabel = UILabel()
    private let eventLogView = UITextView()
    private var events: [String] = []
    private var isRunning = false

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        log("Screen ready", queue: "main")
    }

    private func configureView() {
        view.backgroundColor = .systemBackground

        titleLabel.text = "GCD Queue Demo"
        titleLabel.font = .boldSystemFont(ofSize: 28)
        titleLabel.textAlignment = .center

        explanationLabel.text = "Run two delayed operations concurrently. The interface stays responsive while they work."
        explanationLabel.font = .preferredFont(forTextStyle: .body)
        explanationLabel.textAlignment = .center
        explanationLabel.numberOfLines = 0

        var buttonConfiguration = UIButton.Configuration.filled()
        buttonConfiguration.title = "Start work"
        runButton.configuration = buttonConfiguration
        runButton.addTarget(self, action: #selector(startWork), for: .touchUpInside)

        activityIndicator.hidesWhenStopped = true

        statusLabel.text = "Ready"
        statusLabel.textAlignment = .center
        statusLabel.numberOfLines = 0
        statusLabel.accessibilityIdentifier = "workStatus"

        eventLogView.isEditable = false
        eventLogView.isScrollEnabled = true
        eventLogView.font = .monospacedSystemFont(ofSize: 12, weight: .regular)
        eventLogView.backgroundColor = .secondarySystemBackground
        eventLogView.layer.cornerRadius = 10
        eventLogView.accessibilityIdentifier = "eventLog"

        let stack = UIStackView(arrangedSubviews: [
            titleLabel,
            explanationLabel,
            runButton,
            activityIndicator,
            statusLabel,
            eventLogView
        ])
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            stack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            runButton.heightAnchor.constraint(equalToConstant: 48),
            eventLogView.heightAnchor.constraint(equalToConstant: 220)
        ])
    }

    @objc private func startWork() {
        guard !isRunning else {
            log("Ignored duplicate submission", queue: "main")
            return
        }

        isRunning = true
        runButton.isEnabled = false
        activityIndicator.startAnimating()
        statusLabel.text = "Loading profile and messages..."
        log("Work started; button disabled and indicator shown", queue: "main")

        coordinator.run { [weak self] results in
            guard let self else { return }
            self.isRunning = false
            self.runButton.isEnabled = true
            self.activityIndicator.stopAnimating()
            self.statusLabel.text = results.map(\.detail).joined(separator: "\n")
            self.log("UI updated with \(results.count) results", queue: "main")
        }
    }

    private func log(_ message: String, queue: String) {
        let thread = Thread.isMainThread ? "main-thread" : "background-thread"
        let entry = "[\(queue); \(thread)] \(message)"
        print("[GCD Lab] \(entry)")
        events.append(entry)
        eventLogView.text = events.suffix(12).joined(separator: "\n")
        eventLogView.scrollRangeToVisible(NSRange(location: eventLogView.text.count, length: 0))
    }
}
