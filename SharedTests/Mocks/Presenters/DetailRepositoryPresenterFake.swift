import Shared

class DetailRepositoryPresenterFake: DetailRepositoryPresenter {

    var listedPullRequests: [PullRequest]?
    var displayedError: String?

    func list(pullRequests: [PullRequest]) {
        listedPullRequests = pullRequests
    }

    func displayError(message: String) {
        displayedError = message
    }
}
