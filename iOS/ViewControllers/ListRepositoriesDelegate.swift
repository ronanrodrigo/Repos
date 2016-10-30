import UIKit
import Shared

class ListRepositoriesDelegate: NSObject, UITableViewDelegate {

    var selectRepositoryDelegate: SelectRepositoryDelegate

    init(selectRepositoryDelegate: SelectRepositoryDelegate) {
        self.selectRepositoryDelegate = selectRepositoryDelegate
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectRepositoryDelegate.didSelectedRepository(at: indexPath.row)
        tableView.cellForRow(at: indexPath)?.setSelected(false, animated: true)
    }

}
