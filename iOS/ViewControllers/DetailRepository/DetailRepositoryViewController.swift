import UIKit
import Shared

protocol DetailRepositoryViewControllerDelegate {
    func didList(pullRequests: [PullRequest])
}

protocol SelectPullRequestDelegate {
    func didSelectedPullRequest(at row: Int)
}

class DetailRepositoryViewController: UIViewController, DetailRepositoryViewControllerDelegate, ShowUserAvatarDelegate, SelectPullRequestDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var error: UILabel!

    private var repository: Repository?
    private var dataSource: DetailRepositoryRepositorysDataSource?
    private var delegate: DetailRepositoryDelegate?
    private var cellIdentifier = String(describing: DetailRepositoryTableViewCell.self)
    private var getUserAvatarInteractor: GetUserAvatarInteractor!

    convenience init(repository: Repository) {
        self.init()
        self.repository = repository
    }

    override func viewDidLoad() {
        configureGetUserAvatarInteractor()
        configureTableView()
        configureDetailRepositoryInteractor()
        super.viewDidLoad()
    }

    private func configureGetUserAvatarInteractor() {
        let presenter = GetUserAvatarPresenteriOS(delegate: self)
        getUserAvatarInteractor = GetUserAvatarInteractorFactory.make(presenter: presenter)
    }

    private func configureTableView() {
        let cellNib = UINib(nibName: cellIdentifier, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: cellIdentifier)
        dataSource = DetailRepositoryRepositorysDataSource(getUserAvatarInteractor: getUserAvatarInteractor)
        tableView.dataSource = dataSource
        delegate = DetailRepositoryDelegate(selectPullRequestDelegate: self)
        tableView.delegate = delegate
    }

    private func configureDetailRepositoryInteractor() {
        guard let repository = repository else { return }
        let presenter = DetailRepositoryPresenteriOS(delegate: self)
        let interactor = DetailRepositoryInteractorFactory.make(presenter: presenter)
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        interactor.detail(repository: repository)
    }

    func didList(pullRequests: [PullRequest]) {
        guard let dataSource = dataSource else { return }
        dataSource.pullRequests = dataSource.pullRequests + pullRequests
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        tableView.reloadData()
        UIView.animate(withDuration: 0.5) {
            self.error.alpha = 0
        }
    }

    func didGetAvatar(user: User, image: UIImage) {
        guard let dataSource = dataSource,
            let rowToReload = dataSource.pullRequests.index(where: {$0.user.isEqual(user)}) else { return }
        dataSource.images[user.name] = image
        self.tableView.reloadRows(at: [IndexPath.init(row: rowToReload, section: 0)], with: .none)
    }

    func didSelectedPullRequest(at row: Int) {
        guard let pullRequest = dataSource?.pullRequests[row],
            let navigationController = self.navigationController else { return }
        RepositoriesRouterNavigation(navigationController: navigationController).open(url: pullRequest.url)
    }

}
