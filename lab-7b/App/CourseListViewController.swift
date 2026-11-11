import UIKit

@MainActor
final class CourseListViewController: UITableViewController {
    private let courses: [Course]
    private lazy var cellRegistration = UITableView.CellRegistration<CourseTableViewCell, Course> {
        cell, _, course in
        cell.configure(with: course)
    }

    init(courses: [Course] = Course.samples) {
        self.courses = courses
        super.init(style: .insetGrouped)
    }

    required init?(coder: NSCoder) {
        return nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Courses"
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        configureEmptyState()
    }

    private func configureEmptyState() {
        guard courses.isEmpty else { return }
        let emptyView = UIStackView()
        emptyView.axis = .vertical
        emptyView.alignment = .center
        emptyView.spacing = 8

        let imageView = UIImageView(image: UIImage(systemName: "books.vertical"))
        imageView.tintColor = .secondaryLabel
        imageView.contentMode = .scaleAspectFit
        imageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 48).isActive = true

        let titleLabel = UILabel()
        titleLabel.text = "No courses available"
        titleLabel.font = .preferredFont(forTextStyle: .headline)
        let messageLabel = UILabel()
        messageLabel.text = "Check back later for new courses."
        messageLabel.textColor = .secondaryLabel
        messageLabel.font = .preferredFont(forTextStyle: .subheadline)
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center

        emptyView.addArrangedSubview(imageView)
        emptyView.addArrangedSubview(titleLabel)
        emptyView.addArrangedSubview(messageLabel)
        emptyView.translatesAutoresizingMaskIntoConstraints = false

        let container = UIView()
        container.addSubview(emptyView)
        NSLayoutConstraint.activate([
            emptyView.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            emptyView.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            emptyView.leadingAnchor.constraint(greaterThanOrEqualTo: container.leadingAnchor, constant: 24),
            emptyView.trailingAnchor.constraint(lessThanOrEqualTo: container.trailingAnchor, constant: -24)
        ])
        tableView.backgroundView = container
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        courses.count
    }

    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let course = courses[indexPath.row]
        return tableView.dequeueConfiguredReusableCell(
            using: cellRegistration,
            for: indexPath,
            item: course
        )
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard courses.indices.contains(indexPath.row) else { return }
        let selectedCourse = courses[indexPath.row]
        let detailViewController = CourseDetailViewController(course: selectedCourse)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
