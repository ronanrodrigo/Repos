public class GetUserAvatarInteractorFactory {

    public static func make(presenter: GetUserAvatarPresenter) -> GetUserAvatarInteractor {
        let gateway = UserGateway(webService: WebServiceSession())
        return GetUserAvatarInteractor(userGateway: gateway, presenter: presenter)
    }

}
