public struct RepositoriesGateway {

    private var webService: WebService

    public init(webService: WebService) {
        self.webService = webService
    }

    public func list(page: Int, completion: @escaping ([Repository]?, Error?) -> Void) {
        webService.load(resource: Resources.listRepositories(page: page), completion: { repositories, error in
            completion(repositories, error)
        })
    }

}
