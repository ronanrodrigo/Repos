public protocol User {
    var name: String { get }
    var avatarUrl: URL? { get }
}

public struct UserEntity: User {
    public var name: String
    public var avatarUrl: URL?

    public init(name: String, avatarUrl: URL?) {
        self.name = name
        self.avatarUrl = avatarUrl
    }

}
