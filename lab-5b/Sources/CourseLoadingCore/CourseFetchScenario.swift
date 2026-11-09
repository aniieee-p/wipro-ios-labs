public enum CourseFetchScenario: String, CaseIterable, Identifiable, Sendable {
    case success
    case empty
    case failure

    public var id: Self { self }
}
