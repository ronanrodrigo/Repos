public protocol PullRequest {
    var title: String { get }
    var user: User { get }
    var createdAt: Date { get }
    var body: String { get }
}

public struct PullRequestEntity: PullRequest {
    public var title: String
    public var user: User
    public var createdAt: Date
    public var body: String

    public init(title: String, user: User, createdAt: Date, body: String) {
        self.title = title
        self.user = user
        self.createdAt = createdAt
        self.body = body
    }

}
