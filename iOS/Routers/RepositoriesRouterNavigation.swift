import Shared

class RepositoriesRouterNavigation: RepositoriesRouter {
    
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func list() {
        let listRepositoriesViewController = ListRepositoriesViewController()
        self.navigationController.viewControllers = [listRepositoriesViewController]
    }

}
