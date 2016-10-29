public struct UserGateway {

    private var webService: WebService

    public init(webService: WebService) {
        self.webService = webService
    }

    public func getAvatar(url: URL, completion: @escaping (Data?) -> ()) {
        webService.download(url: url) { data in
            completion(data)
        }
    }

}
