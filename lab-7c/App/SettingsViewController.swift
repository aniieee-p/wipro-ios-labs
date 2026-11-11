import UIKit

@MainActor
final class SettingsViewController: UIViewController, UITextFieldDelegate {
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let stackView = UIStackView()
    private let nameField = UITextField()
    private let notificationsSwitch = UISwitch()
    private let studyModeControl = UISegmentedControl(items: ["Focused", "Balanced", "Flexible"])
    private let weeklyGoalSlider = UISlider()
    private let weeklyGoalValue = UILabel()
    private let reminderPicker = UIDatePicker()
    private let summaryLabel = UILabel()
    private let lifecycleLabel = UILabel()
    private var hasRefreshedOnAppearance = false

    override func viewDidLoad() {
        super.viewDidLoad()
        LifecycleLogStore.shared.record("Settings: viewDidLoad")
        title = "Study Settings"
        view.backgroundColor = .systemBackground
        configureControls()
        configureLayout()
        configureKeyboardHandling()
        updateSummary()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        LifecycleLogStore.shared.record("Settings: viewWillAppear")
        if hasRefreshedOnAppearance {
            updateSummary()
        }
        hasRefreshedOnAppearance = true
        updateLifecycleLog()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        LifecycleLogStore.shared.record("Settings: viewDidAppear")
        updateLifecycleLog()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        LifecycleLogStore.shared.record("Settings: viewWillDisappear")
        updateLifecycleLog()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        LifecycleLogStore.shared.record("Settings: viewDidDisappear")
    }

    private func configureControls() {
        nameField.placeholder = "Your name"
        nameField.borderStyle = .roundedRect
        nameField.textContentType = .name
        nameField.autocapitalizationType = .words
        nameField.returnKeyType = .done
        nameField.accessibilityLabel = "Your name"
        nameField.delegate = self
        nameField.addTarget(self, action: #selector(controlChanged), for: .editingChanged)

        notificationsSwitch.isOn = true
        notificationsSwitch.accessibilityLabel = "Enable notifications"
        notificationsSwitch.addTarget(self, action: #selector(controlChanged), for: .valueChanged)

        studyModeControl.selectedSegmentIndex = 1
        studyModeControl.accessibilityLabel = "Study mode"
        studyModeControl.addTarget(self, action: #selector(controlChanged), for: .valueChanged)

        weeklyGoalSlider.minimumValue = 1
        weeklyGoalSlider.maximumValue = 20
        weeklyGoalSlider.value = 8
        weeklyGoalSlider.isContinuous = true
        weeklyGoalSlider.accessibilityLabel = "Weekly study goal in hours"
        weeklyGoalSlider.addTarget(self, action: #selector(controlChanged), for: .valueChanged)
        weeklyGoalValue.textAlignment = .right
        weeklyGoalValue.accessibilityLabel = "Weekly goal value"

        reminderPicker.datePickerMode = .time
        reminderPicker.preferredDatePickerStyle = .compact
        reminderPicker.accessibilityLabel = "Study reminder time"
        reminderPicker.addTarget(self, action: #selector(controlChanged), for: .valueChanged)

        summaryLabel.font = .preferredFont(forTextStyle: .body)
        summaryLabel.adjustsFontForContentSizeCategory = true
        summaryLabel.numberOfLines = 0
        summaryLabel.accessibilityIdentifier = "settingsSummary"

        lifecycleLabel.font = .monospacedSystemFont(ofSize: 11, weight: .regular)
        lifecycleLabel.adjustsFontForContentSizeCategory = true
        lifecycleLabel.textColor = .secondaryLabel
        lifecycleLabel.numberOfLines = 0
        lifecycleLabel.accessibilityIdentifier = "lifecycleEvents"
    }

    private func configureLayout() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 18

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)

        stackView.addArrangedSubview(makeHeader())
        stackView.addArrangedSubview(makeLabeledControl(title: "Name", control: nameField))
        stackView.addArrangedSubview(makeLabeledControl(title: "Notifications", control: notificationsSwitch))
        stackView.addArrangedSubview(makeLabeledControl(title: "Study mode", control: studyModeControl))
        stackView.addArrangedSubview(makeLabeledControl(title: "Weekly goal", control: makeSliderRow()))
        stackView.addArrangedSubview(makeLabeledControl(title: "Reminder time", control: reminderPicker))
        stackView.addArrangedSubview(makePanel(title: "Current settings", body: summaryLabel))
        stackView.addArrangedSubview(makeNavigationButton())
        stackView.addArrangedSubview(makePanel(title: "Recent lifecycle events", body: lifecycleLabel))

        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24)
        ])
        contentView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
    }

    private func makeHeader() -> UIView {
        let titleLabel = UILabel()
        titleLabel.text = "Study preferences"
        titleLabel.font = .preferredFont(forTextStyle: .largeTitle)
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.numberOfLines = 0

        let subtitle = UILabel()
        subtitle.text = "Change a control to update the summary."
        subtitle.font = .preferredFont(forTextStyle: .subheadline)
        subtitle.textColor = .secondaryLabel
        subtitle.numberOfLines = 0

        let header = UIStackView(arrangedSubviews: [titleLabel, subtitle])
        header.axis = .vertical
        header.spacing = 6
        return header
    }

    private func makeLabeledControl(title: String, control: UIView) -> UIView {
        let label = UILabel()
        label.text = title
        label.font = .preferredFont(forTextStyle: .headline)
        label.adjustsFontForContentSizeCategory = true

        let row = UIStackView(arrangedSubviews: [label, control])
        row.axis = .horizontal
        row.alignment = .center
        row.spacing = 12
        control.setContentHuggingPriority(.defaultHigh, for: .horizontal)

        let group = UIStackView(arrangedSubviews: [row])
        group.axis = .vertical
        return group
    }

    private func makeSliderRow() -> UIView {
        let sliderRow = UIStackView(arrangedSubviews: [weeklyGoalSlider, weeklyGoalValue])
        sliderRow.axis = .horizontal
        sliderRow.alignment = .center
        sliderRow.spacing = 12
        weeklyGoalValue.widthAnchor.constraint(greaterThanOrEqualToConstant: 70).isActive = true
        return sliderRow
    }

    private func makePanel(title: String, body: UIView) -> UIView {
        let heading = UILabel()
        heading.text = title
        heading.font = .preferredFont(forTextStyle: .headline)
        heading.adjustsFontForContentSizeCategory = true
        let panel = UIStackView(arrangedSubviews: [heading, body])
        panel.axis = .vertical
        panel.spacing = 10
        panel.isLayoutMarginsRelativeArrangement = true
        panel.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 14, leading: 14, bottom: 14, trailing: 14)
        panel.backgroundColor = .secondarySystemBackground
        panel.layer.cornerRadius = 12
        return panel
    }

    private func makeNavigationButton() -> UIButton {
        var configuration = UIButton.Configuration.bordered()
        configuration.title = "Open lifecycle detail"
        configuration.image = UIImage(systemName: "arrow.right")
        configuration.imagePlacement = .trailing
        let button = UIButton(configuration: configuration)
        button.accessibilityLabel = "Open lifecycle detail screen"
        button.addTarget(self, action: #selector(openDetail), for: .touchUpInside)
        return button
    }

    private func configureKeyboardHandling() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillChangeFrame(_:)),
            name: UIResponder.keyboardWillChangeFrameNotification,
            object: nil
        )
    }

    @objc private func keyboardWillChangeFrame(_ notification: Notification) {
        guard let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            scrollView.contentInset.bottom = 0
            scrollView.verticalScrollIndicatorInsets.bottom = 0
            return
        }

        let frameInView = view.convert(frame, from: nil)
        let overlap = max(0, view.bounds.maxY - frameInView.minY)
        scrollView.contentInset.bottom = overlap
        scrollView.verticalScrollIndicatorInsets.bottom = overlap
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    @objc private func controlChanged() {
        updateSummary()
    }

    private func updateSummary() {
        let modes = ["Focused", "Balanced", "Flexible"]
        let index = studyModeControl.selectedSegmentIndex
        let mode = modes.indices.contains(index) ? modes[index] : "Balanced"
        let selection = ControlSelection(
            name: nameField.text ?? "",
            notificationsEnabled: notificationsSwitch.isOn,
            studyMode: mode,
            weeklyGoal: Int(weeklyGoalSlider.value.rounded()),
            reminderDate: reminderPicker.date
        )
        weeklyGoalValue.text = "\(selection.weeklyGoal) hours"
        summaryLabel.text = selection.summary
    }

    private func updateLifecycleLog() {
        lifecycleLabel.text = LifecycleLogStore.shared.entries.suffix(5).joined(separator: "\n")
    }

    @objc private func openDetail() {
        view.endEditing(true)
        navigationController?.pushViewController(LifecycleDetailViewController(), animated: true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
