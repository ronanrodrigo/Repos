import UIKit
import Shared

class DetailRepositoryRepositorysDataSource: NSObject, UITableViewDataSource {

    var pullRequests: [PullRequest] = []
    var images: [String: UIImage] = [String: UIImage]()
    private var cellIdentifier = String(describing: DetailRepositoryTableViewCell.self)
    private var getUserAvatarInteractor: GetUserAvatarInteractor

    init(getUserAvatarInteractor: GetUserAvatarInteractor) {
        self.getUserAvatarInteractor = getUserAvatarInteractor
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pullRequests.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? DetailRepositoryTableViewCell {
            let pullRequest = pullRequests[indexPath.row]
            cell.configure(pullRequest: pullRequest)
            if let image = images[pullRequest.user.name] {
                cell.configure(image: image)
            } else {
                getUserAvatarInteractor.get(user: pullRequest.user)
            }
            return cell
        } else {
            return tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        }
    }

}
