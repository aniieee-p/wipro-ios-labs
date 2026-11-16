public enum CourseFetchScenario: String, CaseIterable, Identifiable {
    case success
    case empty
    case failure

    public var id: String { rawValue }
}
