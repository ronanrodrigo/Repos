import Shared

class ListRepositoriesPresenteriOS: ListRepositoriesPresenter {

    private var delegate: ListRepositoriesViewControllerDelegate

    init(delegate: ListRepositoriesViewControllerDelegate) {
        self.delegate = delegate
    }

    func list(repositories: [Repository]) {
        delegate.didList(repositories: repositories)
    }

    func displayError(message: String) {
        delegate.didDisplayError(message: message)
    }

}
