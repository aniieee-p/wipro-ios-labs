public enum TaskFilter: String, CaseIterable, Hashable, Identifiable, Sendable {
    case all = "All"
    case active = "Active"
    case completed = "Completed"

    public var id: String { rawValue }
}
