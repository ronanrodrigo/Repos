public protocol Repository {
    var name: String { get }
    var description: String { get }
    var owner: User { get }
    var stars: Int { get }
    var forks: Int { get }
    init?(dictionary: JSONDictionary)
}

public struct RepositoryEntity: Repository {
    public var name: String
    public var description: String
    public var owner: User
    public var stars: Int
    public var forks: Int

    public init (name: String, description: String, owner: User, stars: Int, forks: Int) {
        self.name = name
        self.description = description
        self.owner = owner
        self.stars = stars
        self.forks = forks
    }

    public init?(dictionary: JSONDictionary) {
        guard let name = dictionary["name"] as? String,
            let description = dictionary["description"] as? String,
            let stars = dictionary["stargazers_count"] as? Int,
            let forks = dictionary["forks_count"] as? Int,
            let ownerDictionary = dictionary["owner"] as? JSONDictionary,
            let owner = UserEntity(dictionary: ownerDictionary) else { return nil }

        self.init(name: name, description: description, owner: owner, stars: stars, forks: forks)
    }

}
