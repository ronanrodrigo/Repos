import Shared

class ListRepositoriesPresenteriOS: ListRepositoriesPresenter {

    private weak var delegate: ListRepositoriesViewControllerDelegate?

    init(delegate: ListRepositoriesViewControllerDelegate) {
        self.delegate = delegate
    }

    func list(repositories: [Repository]) {
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            self.delegate?.didList(repositories: repositories)
        }
    }

    func displayError(message: String) {
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            self.delegate?.didDisplayError(message: message)
        }
    }

}
