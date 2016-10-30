import Shared

class DetailRepositoryPresenteriOS: DetailRepositoryPresenter {

    var delegate: DetailRepositoryViewControllerDelegate

    init(delegate: DetailRepositoryViewControllerDelegate) {
        self.delegate = delegate
    }

    func list(pullRequests: [PullRequest]) {
        DispatchQueue.main.async {
            self.delegate.didList(pullRequests: pullRequests)
        }
    }

    func displayError(message: String) {
    }

}
