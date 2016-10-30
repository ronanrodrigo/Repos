import UIKit
import Shared

class ListRepositoriesDataSource: NSObject, UITableViewDataSource {

    var repositories: [Repository] = []
    var images: [String: UIImage] = [String: UIImage]()
    private var cellIdentifier = String(describing: RepositoryTableViewCell.self)
    private var getUserAvatarInteractor: GetUserAvatarInteractor

    init(getUserAvatarInteractor: GetUserAvatarInteractor) {
        self.getUserAvatarInteractor = getUserAvatarInteractor
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? RepositoryTableViewCell {
            let repository = repositories[indexPath.row]
            cell.configure(repository: repository)
            if let image = images[repository.owner.name] {
                cell.configure(image: image)
            } else {
                getUserAvatarInteractor.get(user: repository.owner)
            }
            return cell
        } else {
            return tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        }
    }

}
