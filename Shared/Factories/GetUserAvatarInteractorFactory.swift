public class GetUserAvatarInteractorFactory {

    public static func make(presenter: GetUserAvatarPresenter) -> GetUserAvatarInteractor {
        return GetUserAvatarInteractor(
            userGateway: UserGateway(webService: WebServiceSession()),
            presenter: presenter)
    }

}
