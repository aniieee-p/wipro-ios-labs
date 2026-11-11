import Foundation

public struct ControlSelection: Equatable, Sendable {
    public let name: String
    public let notificationsEnabled: Bool
    public let studyMode: String
    public let weeklyGoal: Int
    public let reminderDate: Date

    public init(
        name: String,
        notificationsEnabled: Bool,
        studyMode: String,
        weeklyGoal: Int,
        reminderDate: Date
    ) {
        self.name = name.trimmingCharacters(in: .whitespacesAndNewlines)
        self.notificationsEnabled = notificationsEnabled
        self.studyMode = studyMode
        self.weeklyGoal = weeklyGoal
        self.reminderDate = reminderDate
    }

    public var summary: String {
        let displayName = name.isEmpty ? "Not provided" : name
        let notificationStatus = notificationsEnabled ? "On" : "Off"
        let time = reminderDate.formatted(date: .omitted, time: .shortened)
        return """
        Name: \(displayName)
        Notifications: \(notificationStatus)
        Study mode: \(studyMode)
        Weekly goal: \(weeklyGoal) hours
        Reminder: \(time)
        """
    }
}
