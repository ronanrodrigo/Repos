import UIKit
import Shared

class ListRepositoriesDataSource: NSObject, UITableViewDataSource {

    var repositories: [Repository] = []

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryTableViewCell") {
            cell.textLabel?.text = repositories[indexPath.row].name
            return cell
        } else {
            return UITableViewCell()
        }
    }

}
