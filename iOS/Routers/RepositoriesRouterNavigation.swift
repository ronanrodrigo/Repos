import Shared
import SafariServices

class RepositoriesRouterNavigation: RepositoriesRouter {

    private var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func list() {
        let listRepositoriesViewController = ListRepositoriesViewController()
        listRepositoriesViewController.setStatusBarStyle(UIStatusBarStyle.lightContent)
        navigationController.setStatusBarStyle(UIStatusBarStyle.lightContent)
        navigationController.viewControllers = [listRepositoriesViewController]
    }

    func detail(repository: Repository) {
        detail(repository: repository, userImage: nil)
    }

    func detail(repository: Repository, userImage: UIImage?) {
        let detailRepositoryViewController = DetailRepositoryViewController(repository: repository)
        let userAvatar = UIImageView(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
        userAvatar.image = userImage
        userAvatar.cornerRadius = 4.0
        userAvatar.clipsToBounds = true
        detailRepositoryViewController.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: userAvatar)
        detailRepositoryViewController.navigationItem.title = repository.name
        navigationController.pushViewController(detailRepositoryViewController, animated: true)
    }

    func open(url: URL) {
        let safariViewController = SFSafariViewController(url: url, entersReaderIfAvailable: true)
        safariViewController.modalPresentationStyle = .overFullScreen
        navigationController.present(safariViewController, animated: true, completion: nil)
    }

}
