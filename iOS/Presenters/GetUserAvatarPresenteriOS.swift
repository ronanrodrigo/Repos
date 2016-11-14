import Shared

class GetUserAvatarPresenteriOS: GetUserAvatarPresenter {

    private weak var delegate: ShowUserAvatarDelegate?

    init(delegate: ShowUserAvatarDelegate) {
        self.delegate = delegate
    }

    func showAvatar(user: User, imageData: Data) {
        guard let image = UIImage(data: imageData) else { return }
        DispatchQueue.main.async {
            self.delegate?.didGetAvatar(user: user, image: image)
        }
    }

}
