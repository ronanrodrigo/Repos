import Shared

class GetUserAvatarPresenterFake: GetUserAvatarPresenter {

    var userWithAvatar: User?
    var showedImageData: Data?

    func showAvatar(user: User, imageData: Data) {
        userWithAvatar = user
        showedImageData = imageData
    }

}
