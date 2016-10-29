import UIKit
import Shared

class ListRepositoriesDataSource: NSObject, UITableViewDataSource {

    var repositories: [Repository] = []
    private var cellIdentifier = String(describing: RepositoryTableViewCell.self)

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) {
            cell.textLabel?.text = repositories[indexPath.row].name
            return cell
        } else {
            return UITableViewCell()
        }
    }

}
