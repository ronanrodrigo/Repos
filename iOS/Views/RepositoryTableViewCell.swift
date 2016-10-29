import UIKit
import Shared

class RepositoryTableViewCell: UITableViewCell {

    @IBOutlet weak var repositoryName: UILabel!
    @IBOutlet weak var repositoryDescription: UILabel!
    @IBOutlet weak var repositoryForks: UILabel!
    @IBOutlet weak var repositoryStars: UILabel!
    @IBOutlet weak var ownerLogin: UILabel!
    @IBOutlet weak var ownerAvatar: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(repository: Repository) {
        repositoryName.text = repository.name
        repositoryDescription.text = repository.description
        repositoryForks.text = "\(repository.forks)"
        repositoryStars.text = "\(repository.stars)"
        ownerLogin.text = repository.owner.name
    }

}
