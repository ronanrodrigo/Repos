public class DetailRepositoryInteractor {

    private var gateway: PullRequestsGateway
    private var presenter: DetailRepositoryPresenter

    init(gateway: PullRequestsGateway, presenter: DetailRepositoryPresenter) {
        self.gateway = gateway
        self.presenter = presenter
    }

    public func detail(repository: Repository) {
        guard let pullRequestsUrl = URL(string: "https://api.github.com/repos/\(repository.owner.name)/\(repository.name)/pulls")
            else { return }
        gateway.list(pullRequestsUrl: pullRequestsUrl) { pullRequests, error in
            if let pullRequests = pullRequests {
                self.presenter.list(pullRequests: pullRequests)
            } else if let error = error {
                self.presenter.displayError(message: error.localizedDescription)
            } else {
                self.presenter.displayError(message: "Unknow error")
            }
        }
    }

}
