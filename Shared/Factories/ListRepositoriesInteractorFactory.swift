public class ListRepositoriesInteractorFactory {
    
    public static func make(presenter: ListRepositoriesPresenter) -> ListRepositoriesInteractor {
        let webService = WebServiceSession()
        let gateway = RepositoriesGatewayGithub(webService: webService)

        return ListRepositoriesInteractor(gateway: gateway, presenter: presenter)
    }
    
}
