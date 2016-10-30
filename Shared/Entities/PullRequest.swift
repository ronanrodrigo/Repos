public protocol PullRequest {
    var title: String { get }
    var user: User { get }
    var createdAt: Date { get }
    var body: String { get }
    var url: URL { get }
    init?(dictionary: JSONDictionary)
}

public struct PullRequestEntity: PullRequest {
    public var title: String
    public var user: User
    public var createdAt: Date
    public var body: String
    public var url: URL

    public init(title: String, user: User, createdAt: Date, body: String, url: URL) {
        self.title = title
        self.user = user
        self.createdAt = createdAt
        self.body = body
        self.url = url
    }

    public init?(dictionary: JSONDictionary) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let title = dictionary["title"] as? String,
            let body = dictionary["body"] as? String,
            let createdAtString = dictionary["created_at"] as? String,
            let createdAt = dateFormatter.date(from: createdAtString),
            let userDictionary = dictionary["user"] as? JSONDictionary,
            let user = UserEntity(dictionary: userDictionary),
            let urlString = dictionary["html_url"] as? String,
            let url = URL(string: urlString) else { return nil }

        self.init(title: title, user: user, createdAt: createdAt, body: body, url: url)
    }

}
