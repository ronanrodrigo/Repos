public struct PullRequestsGateway {

    private var webService: WebService

    public init(webService: WebService) {
        self.webService = webService
    }

    public func list(pullRequestsUrl: URL, completion: @escaping ([PullRequest]?, Error?) -> ()) {
        webService.load(resource: Resources.listPullRequests(url: pullRequestsUrl)) { pullRequests, error in
            completion(pullRequests, error)
        }
    }

}
