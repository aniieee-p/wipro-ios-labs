import UIKit

@MainActor
final class CourseDetailViewController: UIViewController {
    private let course: Course
    private let titleLabel = UILabel()
    private let instructorLabel = UILabel()
    private let durationLabel = UILabel()
    private let summaryLabel = UILabel()

    init(course: Course) {
        self.course = course
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        return nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Course Details"
        view.backgroundColor = .systemBackground
        configureLabels()
        configureLayout()
    }

    private func configureLabels() {
        titleLabel.text = course.title
        titleLabel.font = .preferredFont(forTextStyle: .largeTitle)
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.numberOfLines = 0
        titleLabel.accessibilityIdentifier = "detailCourseTitle"

        instructorLabel.text = "Instructor: \(course.instructor)"
        instructorLabel.font = .preferredFont(forTextStyle: .headline)
        instructorLabel.adjustsFontForContentSizeCategory = true
        instructorLabel.numberOfLines = 0

        durationLabel.text = "Duration: \(course.duration)"
        durationLabel.font = .preferredFont(forTextStyle: .subheadline)
        durationLabel.adjustsFontForContentSizeCategory = true
        durationLabel.textColor = .secondaryLabel

        summaryLabel.text = course.summary
        summaryLabel.font = .preferredFont(forTextStyle: .body)
        summaryLabel.adjustsFontForContentSizeCategory = true
        summaryLabel.numberOfLines = 0
        summaryLabel.accessibilityIdentifier = "detailCourseSummary"
    }

    private func configureLayout() {
        let stack = UIStackView(arrangedSubviews: [
            titleLabel,
            instructorLabel,
            durationLabel,
            summaryLabel
        ])
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            stack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32)
        ])
    }
}
