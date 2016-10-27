public protocol Repository {
    var name: String { get }
    var description: String { get }
    var owner: User { get }
    var stars: Int { get }
    var forks: Int { get }
}

public struct RepositoryEntity: Repository {
    public var name: String
    public var description: String
    public var owner: User
    public var stars: Int
    public var forks: Int
}
