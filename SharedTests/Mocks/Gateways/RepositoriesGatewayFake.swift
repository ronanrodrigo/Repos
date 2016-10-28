import Shared

class RepositoriesGatewayFake: RepositoriesGateway {

    var webService: WebService

    init(webService: WebService) {
        self.webService = webService
    }

    func list(completion: @escaping ([Repository]?, Error?) -> ()) {
        webService.load(resource: listResource, completion: { repositories, error in
            completion(repositories, error)
        })
    }

}
