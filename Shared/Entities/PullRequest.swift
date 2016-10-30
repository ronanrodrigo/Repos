public protocol PullRequest {
    var title: String { get }
    var user: User { get }
    var createdAt: Date { get }
    var body: String { get }
    init?(dictionary: JSONDictionary)
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

    public init?(dictionary: JSONDictionary) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let title = dictionary["title"] as? String,
            let body = dictionary["body"] as? String,
            let createdAtString = dictionary["created_at"] as? String,
            let createdAt = dateFormatter.date(from: createdAtString),
            let userDictionary = dictionary["user"] as? JSONDictionary,
            let user = UserEntity(dictionary: userDictionary) else { return nil }

        self.init(title: title, user: user, createdAt: createdAt, body: body)
    }

}
