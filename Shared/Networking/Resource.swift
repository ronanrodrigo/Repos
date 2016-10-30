public typealias JSONDictionary = [String: AnyObject]

public struct Resource<T> {
    public let url: URL
    public let parse: (Data) -> T?
}

public extension Resource {

    public init(url: URL, parseJSON: @escaping (Any) -> T?) {
        self.url = url
        self.parse = { data in
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
            return json.flatMap(parseJSON)
        }
    }

}

public struct Resources {

    private static let baseUrl = "https://api.github.com"

    private static let listRepositories = "\(baseUrl)/search/repositories?q=language:Java&sort=stars"
    static func listRepositories(page: Int = 1) -> Resource<[Repository]> {
        let listRepositoriesUrl = URL(string: listRepositories + "&page=\(page)")!
        return Resource<[Repository]>(url: listRepositoriesUrl, parseJSON: { json in
            guard let dictionary = json as? JSONDictionary else { return nil }
            guard let dictionaries = dictionary["items"] as? [JSONDictionary] else { return nil }

            return dictionaries.flatMap(RepositoryEntity.init)
        })
    }

    static func listPullRequests(url: URL) -> Resource<[PullRequest]> {
        return Resource<[PullRequest]>(url: url, parseJSON: { json -> [PullRequest]? in
            guard let dictionaries = json as? [JSONDictionary] else { return nil }
            return dictionaries.flatMap(PullRequestEntity.init)
        })
    }

}
