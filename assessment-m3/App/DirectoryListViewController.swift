import Combine
import UIKit

@MainActor
final class DirectoryListViewController: UITableViewController {
    private let profile: ProfileFormInput
    private let viewModel: DirectoryViewModel
    private var stateObservation: AnyCancellable?
    private let retryButton = UIButton(type: .system)
    private let cancelButton = UIButton(type: .system)
    private let messageLabel = UILabel()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private let emptyView = UIView()
    private var users: [DirectoryUser] = []

    init(profile: ProfileFormInput, service: UserDirectoryService = UserDirectoryService(transport: URLSessionDirectoryTransport())) {
        self.profile = profile
        self.viewModel = DirectoryViewModel(service: service)
        super.init(style: .plain)
    }

    required init?(coder: NSCoder) {
        return nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "People"
        navigationItem.largeTitleDisplayMode = .never
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "PersonCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 76
        configureStateView()
        bindViewModel()
        viewModel.load()
    }

    private func configureStateView() {
        emptyView.backgroundColor = .systemBackground
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        messageLabel.font = .preferredFont(forTextStyle: .body)
        messageLabel.adjustsFontForContentSizeCategory = true
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        retryButton.translatesAutoresizingMaskIntoConstraints = false
        retryButton.setTitle("Retry", for: .normal)
        retryButton.setImage(UIImage(systemName: "arrow.clockwise"), for: .normal)
        retryButton.accessibilityLabel = "Retry loading people"
        retryButton.addTarget(self, action: #selector(retry), for: .touchUpInside)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.setTitle("Cancel request", for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelRequest), for: .touchUpInside)
        emptyView.addSubview(messageLabel)
        emptyView.addSubview(activityIndicator)
        emptyView.addSubview(retryButton)
        emptyView.addSubview(cancelButton)
        NSLayoutConstraint.activate([
            messageLabel.leadingAnchor.constraint(equalTo: emptyView.leadingAnchor, constant: 28),
            messageLabel.trailingAnchor.constraint(equalTo: emptyView.trailingAnchor, constant: -28),
            messageLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor),
            activityIndicator.bottomAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -16),
            retryButton.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor),
            retryButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 16),
            retryButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 44),
            cancelButton.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor),
            cancelButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 16),
            cancelButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 44)
        ])
        tableView.backgroundView = emptyView
    }

    private func bindViewModel() {
        stateObservation = viewModel.$state.sink { [weak self] state in
            Task { @MainActor in
                self?.render(state)
            }
        }
    }

    private func render(_ state: DirectoryViewModel.State) {
        activityIndicator.stopAnimating()
        retryButton.isHidden = true
        cancelButton.isHidden = true
        switch state {
        case .idle, .loading:
            users = []
            messageLabel.text = "Loading people for \(profile.name)…"
            activityIndicator.startAnimating()
            cancelButton.isHidden = false
        case .success(let loadedUsers):
            users = loadedUsers
            tableView.backgroundView = loadedUsers.isEmpty ? emptyView : nil
            if loadedUsers.isEmpty {
                messageLabel.text = "No people were returned. Try again."
                retryButton.isHidden = false
            }
            tableView.reloadData()
        case .empty:
            users = []
            tableView.backgroundView = emptyView
            messageLabel.text = "No people were returned."
            retryButton.isHidden = false
            tableView.reloadData()
        case .failure(let error):
            users = []
            tableView.backgroundView = emptyView
            messageLabel.text = "Couldn’t load the directory.\n\(error)"
            retryButton.isHidden = false
            tableView.reloadData()
        case .cancelled:
            users = []
            tableView.backgroundView = emptyView
            messageLabel.text = "Loading was cancelled."
            retryButton.isHidden = false
            tableView.reloadData()
        }
    }

    @objc private func retry() {
        viewModel.load()
    }

    @objc private func cancelRequest() {
        viewModel.cancel()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }

    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonCell", for: indexPath)
        guard users.indices.contains(indexPath.row) else { return cell }
        let user = users[indexPath.row]
        var content = UIListContentConfiguration.subtitleCell()
        content.text = user.name
        content.secondaryText = "\(user.email)\n\(user.company.name)"
        content.secondaryTextProperties.numberOfLines = 2
        content.prefersSideBySideTextAndSecondaryText = false
        cell.contentConfiguration = content
        cell.accessoryType = .disclosureIndicator
        cell.accessibilityLabel = "\(user.name), \(user.email), \(user.company.name)"
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard users.indices.contains(indexPath.row) else { return }
        navigationController?.pushViewController(
            DirectoryDetailViewController(user: users[indexPath.row], profile: profile),
            animated: true
        )
    }
}
