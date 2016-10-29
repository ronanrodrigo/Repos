public protocol User {
    var name: String { get }
    var avatarUrl: URL? { get }
    init?(dictionary: JSONDictionary)
}

public struct UserEntity: User {
    public var name: String
    public var avatarUrl: URL?

    public init(name: String, avatarUrl: URL?) {
        self.name = name
        self.avatarUrl = avatarUrl
    }

    public init?(dictionary: JSONDictionary) {
        guard let name = dictionary["login"] as? String,
            let avatarUrlString = dictionary["avatar_url"] as? String else { return nil }

        self.init(name: name, avatarUrl: URL(string: avatarUrlString))
    }

}
