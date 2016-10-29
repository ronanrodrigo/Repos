public class GetUserAvatarInteractor {

    var userGateway: UserGateway
    var presenter: GetUserAvatarPresenter

    init(userGateway: UserGateway, presenter: GetUserAvatarPresenter) {
        self.userGateway = userGateway
        self.presenter = presenter
    }

    public func get(user: User) {
        guard let avatarUrl = user.avatarUrl else { return }
        userGateway.getAvatar(url: avatarUrl) { imageData in
            imageData.flatMap {self.presenter.showAvatar(user: user, imageData: $0)}
        }
    }

}
