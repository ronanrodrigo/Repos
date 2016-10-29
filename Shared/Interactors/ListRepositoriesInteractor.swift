public class ListRepositoriesInteractor {

    var gateway: RepositoriesGateway
    var presenter: ListRepositoriesPresenter

    public init(gateway: RepositoriesGateway, presenter: ListRepositoriesPresenter) {
        self.gateway = gateway
        self.presenter = presenter
    }

    public func list() {
        self.gateway.list { repositories, error in
            if let repositories = repositories {
                self.presenter.list(repositories: repositories)
            } else if let error = error {
                self.presenter.displayError(message: error.localizedDescription)
            } else {
                self.presenter.displayError(message: "Unknow error")
            }
        }
    }

}
