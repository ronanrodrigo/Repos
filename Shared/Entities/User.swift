public protocol User {
    var name: String { get }
    var avatarUrl: URL? { get }
}

public struct UserEntity: User {
    public var name: String
    public var avatarUrl: URL?
}
