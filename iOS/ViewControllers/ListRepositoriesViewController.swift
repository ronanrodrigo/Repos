import UIKit
import Shared

protocol ListRepositoriesViewControllerDelegate {
    func didList(repositories: [Repository])
    func didDisplayError(message: String)
}

class ListRepositoriesViewController: UIViewController, ListRepositoriesViewControllerDelegate {

    @IBOutlet weak var tableView: UITableView!

    private var listRepositoriesInteractor: ListRepositoriesInteractor?
    private var dataSource: ListRepositoriesDataSource?

    override func viewDidLoad() {
        configureTableView()
        configureInteractor()
        super.viewDidLoad()
    }

    private func configureTableView() {
        let cellNib = UINib(nibName: "RepositoryTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "RepositoryTableViewCell")
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
        DispatchQueue.main.async {
            dataSource.repositories = dataSource.repositories + repositories
            self.tableView.reloadData()
        }
    }

    func didDisplayError(message: String) {
    }

}
