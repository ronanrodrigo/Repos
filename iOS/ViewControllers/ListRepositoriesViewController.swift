import UIKit
import Shared

protocol ListRepositoriesViewControllerDelegate {
    func didList(repositories: [Repository])
    func didDisplayError(message: String)
}

protocol ShowUserAvatarDelegate {
    func didGetAvatar(user: User, image: UIImage)
}

protocol SelectRepositoryDelegate {
    func didSelectedRepository(at row: Int)
}

class ListRepositoriesViewController: UIViewController, ListRepositoriesViewControllerDelegate, ShowUserAvatarDelegate, SelectRepositoryDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var error: UILabel!

    private var getUserAvatarInteractor: GetUserAvatarInteractor!
    private var listRepositoriesInteractor: ListRepositoriesInteractor?
    private var dataSource: ListRepositoriesDataSource?
    private var delegate: ListRepositoriesDelegate?
    private var cellIdentifier = String(describing: RepositoryTableViewCell.self)

    override func viewDidLoad() {
        configureGetUserAvatarInteractor()
        configureTableView()
        configureListRepositoriesInteractor()
        super.viewDidLoad()
    }

    private func configureGetUserAvatarInteractor() {
        let presenter = GetUserAvatarPresenteriOS(delegate: self)
        getUserAvatarInteractor = GetUserAvatarInteractorFactory.make(presenter: presenter)
    }

    private func configureTableView() {
        let cellNib = UINib(nibName: cellIdentifier, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: cellIdentifier)
        dataSource = ListRepositoriesDataSource(getUserAvatarInteractor: getUserAvatarInteractor)
        tableView.dataSource = dataSource
        delegate = ListRepositoriesDelegate(selectRepositoryDelegate: self)
        tableView.delegate = delegate
    }

    private func configureListRepositoriesInteractor() {
        let presenter = ListRepositoriesPresenteriOS(delegate: self)
        listRepositoriesInteractor = ListRepositoriesInteractorFactory.make(presenter: presenter)
        listRepositoriesInteractor?.list()
    }

    func didList(repositories: [Repository]) {
        guard let dataSource = dataSource else { return }
        dataSource.repositories = dataSource.repositories + repositories
        tableView.reloadData()
        UIView.animate(withDuration: 0.5) {
            self.error.alpha = 0
        }
    }

    func didDisplayError(message: String) {
        error.text = message
    }

    func didGetAvatar(user: User, image: UIImage) {
        guard let dataSource = dataSource,
            let rowToReload = dataSource.repositories.index(where: {$0.owner.isEqual(user)})
            else { return }
        dataSource.images[user.name] = image
        self.tableView.reloadRows(at: [IndexPath.init(row: rowToReload, section: 0)], with: .none)
    }

    func didSelectedRepository(at row: Int) {
        guard let repository = dataSource?.repositories[row],
            let navigationController = navigationController
            else { return }
        let router = RepositoriesRouterNavigation(navigationController: navigationController)
        router.detail(repository: repository, userImage: dataSource?.images[repository.owner.name])
    }

}
