import UIKit
import Shared

class DetailRepositoryDelegate: NSObject, UITableViewDelegate {

    var selectPullRequestDelegate: SelectPullRequestDelegate

    init(selectPullRequestDelegate: SelectPullRequestDelegate) {
        self.selectPullRequestDelegate = selectPullRequestDelegate
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectPullRequestDelegate.didSelectedPullRequest(at: indexPath.row)
        tableView.cellForRow(at: indexPath)?.setSelected(false, animated: true)
    }

}
