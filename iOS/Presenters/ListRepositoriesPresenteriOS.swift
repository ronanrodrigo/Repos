import Shared

class ListRepositoriesPresenteriOS: ListRepositoriesPresenter {

    private var delegate: ListRepositoriesViewControllerDelegate

    init(delegate: ListRepositoriesViewControllerDelegate) {
        self.delegate = delegate
    }

    func list(repositories: [Repository]) {
        DispatchQueue.main.async {
            self.delegate.didList(repositories: repositories)
        }
    }

    func displayError(message: String) {
        DispatchQueue.main.async {
            self.delegate.didDisplayError(message: message)
        }
    }

}
