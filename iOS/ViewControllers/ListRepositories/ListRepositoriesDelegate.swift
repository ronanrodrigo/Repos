import UIKit
import Shared

class ListRepositoriesDelegate: NSObject, UITableViewDelegate {

    var selectRepositoryDelegate: SelectRepositoryDelegate
    var infiniteScrollDelegate: InfiniteScrollDelegate

    init(selectRepositoryDelegate: SelectRepositoryDelegate, infiniteScrollDelegate: InfiniteScrollDelegate) {
        self.selectRepositoryDelegate = selectRepositoryDelegate
        self.infiniteScrollDelegate = infiniteScrollDelegate
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectRepositoryDelegate.didSelectedRepository(at: indexPath.row)
        tableView.cellForRow(at: indexPath)?.setSelected(false, animated: true)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollHeight = scrollView.contentSize.height
        let scrollPosition = scrollView.contentOffset.y
        let scrollPositionGreatherThanHalfPercent = scrollPosition >= scrollHeight * 0.5
        if scrollHeight > 0 && scrollPositionGreatherThanHalfPercent && infiniteScrollDelegate.loadNextPage {
            infiniteScrollDelegate.nextPage()
        }
    }

}
