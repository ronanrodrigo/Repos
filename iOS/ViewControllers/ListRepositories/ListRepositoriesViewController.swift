import UIKit
import Shared

protocol ListRepositoriesViewControllerDelegate: class {
    func didList(repositories: [Repository])
    func didDisplayError(message: String)
}

protocol ShowUserAvatarDelegate: class {
    func didGetAvatar(user: User, image: UIImage)
}

protocol SelectRepositoryDelegate: class {
    func didSelectedRepository(at row: Int)
}

protocol InfiniteScrollDelegate: class {
    var canLoadNextPage: Bool { get set }
    func nextPage()
}

class ListRepositoriesViewController: UIViewController, ListRepositoriesViewControllerDelegate, ShowUserAvatarDelegate, SelectRepositoryDelegate, InfiniteScrollDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var error: UILabel!
    @IBOutlet weak var loaderBottom: NSLayoutConstraint!

    private var currentPage = 1
    private var getUserAvatarInteractor: GetUserAvatarInteractor!
    private var listRepositoriesInteractor: ListRepositoriesInteractor?
    private var dataSource: GenericDataSource<Repository, RepositoryTableViewCell>?
    private var delegate: ListRepositoriesDelegate?
    private var cellIdentifier = String(describing: RepositoryTableViewCell.self)
    var canLoadNextPage: Bool = true

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
        dataSource = GenericDataSource(getUserAvatarInteractor: getUserAvatarInteractor) { (repository, cell) in
            cell.configure(repository: repository)
            guard let dataSource = self.dataSource, let image = dataSource.images[repository.owner.name] else {
                self.getUserAvatarInteractor.get(user: repository.owner); return
            }
            cell.configure(image: image)
        }
        tableView.dataSource = dataSource
        delegate = ListRepositoriesDelegate(selectRepositoryDelegate: self, infiniteScrollDelegate: self)
        tableView.delegate = delegate
    }

    private func configureListRepositoriesInteractor() {
        let presenter = ListRepositoriesPresenteriOS(delegate: self)
        listRepositoriesInteractor = ListRepositoriesInteractorFactory.make(presenter: presenter)
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        listRepositoriesInteractor?.list()
    }

    func didList(repositories: [Repository]) {
        guard let dataSource = dataSource else { return }
        dataSource.objects = dataSource.objects + repositories
        tableView.reloadData()
        canLoadNextPage = true
        guard let loaderBottom = loaderBottom else { return }
        animate {
            loaderBottom.isActive = false
            self.error.alpha = 0
        }
    }

    func didDisplayError(message: String) {
        error.text = message
        animate {
            self.loaderBottom.constant = self.tableView.frame.height
        }
    }

    func didGetAvatar(user: User, image: UIImage) {
        guard let dataSource = dataSource,
            let rowToReload = dataSource.objects.index(where: {$0.owner.isEqual(user)})
            else { return }
        dataSource.images[user.name] = image
        self.tableView.reloadRows(at: [IndexPath.init(row: rowToReload, section: 0)], with: .none)
    }

    func didSelectedRepository(at row: Int) {
        guard let repository = dataSource?.objects[row],
            let navigationController = navigationController
            else { return }
        let router = RepositoriesRouterNavigation(navigationController: navigationController)
        router.detail(repository: repository, userImage: dataSource?.images[repository.owner.name])
    }

    func nextPage() {
        canLoadNextPage = false
        currentPage = currentPage + 1
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        listRepositoriesInteractor?.list(page: currentPage)
    }

    private func animate(animations: @escaping () -> ()) {
        UIView.animate(withDuration: 0.2) {
            animations()
            self.view.layoutIfNeeded()
        }
    }

}
