public protocol RepositoriesGateway {
    var webService: WebService { get }
    func list(completion: @escaping ([Repository]?, Error?) -> ())
}

public extension RepositoriesGateway {

    public var listUrl: URL {
        get {
            return URL(string: "https://api.github.com/search/repositories?q=language:Java&sort=stars&page=1")!
        }
    }

    public var listResource: Resource<[Repository]> {
        get {
            return Resource<[Repository]>(url: listUrl, parseJSON: { json in
                guard let dictionaries = json as? [JSONDictionary] else { return nil }
                return dictionaries.flatMap(RepositoryEntity.init)})
        }
    }

}
