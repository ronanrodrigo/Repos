public class DetailRepositoryInteractorFactory {

    public static func make(presenter: DetailRepositoryPresenter) -> DetailRepositoryInteractor {
        return DetailRepositoryInteractor(
            gateway: PullRequestsGateway(webService: WebServiceSession()),
            presenter: presenter)
    }

}
