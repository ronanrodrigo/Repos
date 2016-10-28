public protocol ListRepositoriesPresenter {
    func list(repositories: [Repository])
    func displayError(message: String)
}
