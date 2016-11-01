import Shared
import SafariServices

class RepositoriesRouterNavigation: RepositoriesRouter {

    private var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func list() {
        let listRepositoriesViewController = ListRepositoriesViewController()
        addTitleInNavigation(at: listRepositoriesViewController, with: "Repos")
        navigationController.setStatusBarStyle(UIStatusBarStyle.lightContent)
        navigationController.viewControllers = [listRepositoriesViewController]
    }

    func detail(repository: Repository) {
        detail(repository: repository, userImage: nil)
    }

    func detail(repository: Repository, userImage: UIImage?) {
        let detailRepositoryViewController = DetailRepositoryViewController(repository: repository)
        addImageInNavigation(at: detailRepositoryViewController, with: userImage)
        addTitleInNavigation(at: detailRepositoryViewController, with: repository.name)
        navigationController.pushViewController(detailRepositoryViewController, animated: true)
    }

    func open(url: URL) {
        let safariViewController = SFSafariViewController(url: url, entersReaderIfAvailable: true)
        safariViewController.modalPresentationStyle = .overFullScreen
        safariViewController.preferredBarTintColor = UIColor.flatWhiteColorDark()
        navigationController.present(safariViewController, animated: true, completion: nil)
    }

    private func addTitleInNavigation(at viewController: UIViewController, with text: String) {
        viewController.navigationItem.title = "Repos"

    }

    private func addImageInNavigation(at viewController: UIViewController, with image: UIImage?) {
        let userAvatarArea = UIView(frame: CGRect(x: 0, y: 0, width: 22, height: 22))
        let userAvatar = UIImageView(frame: CGRect(x: 0, y: 0, width: 18, height: 18))
        userAvatar.image = image
        userAvatar.cornerRadius = 3.0
        userAvatar.clipsToBounds = true
        userAvatar.center = userAvatarArea.center
        userAvatarArea.cornerRadius = 4.0
        userAvatarArea.clipsToBounds = true
        userAvatarArea.backgroundColor = .white
        userAvatarArea.addSubview(userAvatar)
        viewController.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: userAvatarArea)
    }

}
