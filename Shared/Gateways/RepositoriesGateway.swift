public struct RepositoriesGateway {

    private var webService: WebService

    public init(webService: WebService) {
        self.webService = webService
    }

    public func list(completion: @escaping ([Repository]?, Error?) -> ()) {
        webService.load(resource: Resources.listRepositories) { repositories, error in
            completion(repositories, error)
        }
    }

}
