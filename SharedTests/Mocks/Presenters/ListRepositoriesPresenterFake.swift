import Shared

class ListRepositoriesPresenterFake: ListRepositoriesPresenter {

    var repositories: [Repository] = []
    var errorMessage: String?

    func list(repositories: [Repository]) {
        self.repositories = repositories
    }

    func displayError(message: String) {
        self.errorMessage = message
    }

}
