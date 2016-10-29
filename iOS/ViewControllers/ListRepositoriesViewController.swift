import UIKit
import Shared

protocol ListRepositoriesViewControllerDelegate {
    func didList(repositories: [Repository])
    func didDisplayError(message: String)
}

class ListRepositoriesViewController: UIViewController, ListRepositoriesViewControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var error: UILabel!

    private var listRepositoriesInteractor: ListRepositoriesInteractor?
    private var dataSource: ListRepositoriesDataSource?
    private var cellIdentifier = String(describing: RepositoryTableViewCell.self)

    override func viewDidLoad() {
        configureTableView()
        configureInteractor()
        super.viewDidLoad()
    }

    private func configureTableView() {
        let cellNib = UINib(nibName: cellIdentifier, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: cellIdentifier)
        dataSource = ListRepositoriesDataSource()
        tableView.dataSource = dataSource
    }

    private func configureInteractor() {
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

}
