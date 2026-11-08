#if canImport(UIKit)
import UIKit

final class TaskListView: UIView {
    let taskInputField = UITextField()
    let addButton = UIButton(type: .system)
    let filterControl = UISegmentedControl(items: TaskFilter.allCases.map(\.rawValue))
    let tableView = UITableView()
    let emptyLabel = UILabel()
    let validationLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }

    private func configure() {
        backgroundColor = .systemBackground

        taskInputField.placeholder = "Add a task"
        taskInputField.borderStyle = .roundedRect
        taskInputField.accessibilityLabel = "Task title"

        addButton.setTitle("Add", for: .normal)
        addButton.accessibilityHint = "Adds the task"

        filterControl.selectedSegmentIndex = 0
        filterControl.accessibilityLabel = "Task filter"

        emptyLabel.text = "No tasks in this filter."
        emptyLabel.textColor = .secondaryLabel
        emptyLabel.textAlignment = .center
        emptyLabel.isHidden = true

        validationLabel.text = "Enter a non-empty task title."
        validationLabel.textColor = .systemRed
        validationLabel.isHidden = true

        let inputRow = UIStackView(arrangedSubviews: [taskInputField, addButton])
        inputRow.axis = .horizontal
        inputRow.spacing = 12
        taskInputField.setContentHuggingPriority(.defaultLow, for: .horizontal)
        addButton.setContentHuggingPriority(.required, for: .horizontal)

        let stack = UIStackView(arrangedSubviews: [
            inputRow,
            validationLabel,
            filterControl,
            tableView
        ])
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stack)
        emptyLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(emptyLabel)

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            stack.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            emptyLabel.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
            emptyLabel.centerYAnchor.constraint(equalTo: tableView.centerYAnchor)
        ])
    }
}
#endif
