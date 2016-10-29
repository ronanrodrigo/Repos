public class ListRepositoriesInteractorFactory {

    public static func make(presenter: ListRepositoriesPresenter) -> ListRepositoriesInteractor {
        return ListRepositoriesInteractor(
            gateway: RepositoriesGateway(webService: WebServiceSession()),
            presenter: presenter)
    }

}
