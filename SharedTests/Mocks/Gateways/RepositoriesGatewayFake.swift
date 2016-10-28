import Shared

class RepositoriesGatewayFake: RepositoriesGateway {

    var webService: WebService
    var error: Error?

    init(webService: WebService) {
        self.webService = webService
    }

    func list(completion: @escaping ([Repository]?, Error?) -> ()) {
        webService.load(resource: listResource, completion: { repositories in
            completion(repositories, self.error)
        })
    }

}
