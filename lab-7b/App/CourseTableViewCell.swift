import UIKit

final class CourseTableViewCell: UITableViewCell {
    static let reuseIdentifier = "CourseTableViewCell"

    private let titleLabel = UILabel()
    private let instructorLabel = UILabel()
    private let durationLabel = UILabel()
    private let labelsStack = UIStackView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureLayout()
    }

    required init?(coder: NSCoder) {
        return nil
    }

    func configure(with course: Course) {
        titleLabel.text = course.title
        instructorLabel.text = course.instructor
        durationLabel.text = course.duration
        accessibilityLabel = "\(course.title), \(course.instructor), \(course.duration)"
        accessibilityTraits = .button
    }

    private func configureLayout() {
        titleLabel.font = .preferredFont(forTextStyle: .headline)
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.numberOfLines = 0

        instructorLabel.font = .preferredFont(forTextStyle: .subheadline)
        instructorLabel.adjustsFontForContentSizeCategory = true
        instructorLabel.textColor = .secondaryLabel

        durationLabel.font = .preferredFont(forTextStyle: .caption1)
        durationLabel.adjustsFontForContentSizeCategory = true
        durationLabel.textColor = .secondaryLabel

        labelsStack.axis = .vertical
        labelsStack.spacing = 4
        labelsStack.translatesAutoresizingMaskIntoConstraints = false
        labelsStack.addArrangedSubview(titleLabel)
        labelsStack.addArrangedSubview(instructorLabel)
        labelsStack.addArrangedSubview(durationLabel)
        contentView.addSubview(labelsStack)

        NSLayoutConstraint.activate([
            labelsStack.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            labelsStack.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            labelsStack.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor, constant: 8),
            labelsStack.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor, constant: -8)
        ])

        accessoryType = .disclosureIndicator
    }
}
