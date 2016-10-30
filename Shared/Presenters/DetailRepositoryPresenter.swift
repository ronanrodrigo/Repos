public protocol DetailRepositoryPresenter {
    func list(pullRequests: [PullRequest])
    func displayError(message: String)
}
