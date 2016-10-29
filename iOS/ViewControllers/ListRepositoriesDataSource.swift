import UIKit
import Shared

class ListRepositoriesDataSource: NSObject, UITableViewDataSource {

    var repositories: [Repository] = []
    private var cellIdentifier = String(describing: RepositoryTableViewCell.self)

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? RepositoryTableViewCell {
            cell.configure(repository: repositories[indexPath.row])
            return cell
        } else {
            return tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        }
    }

}
