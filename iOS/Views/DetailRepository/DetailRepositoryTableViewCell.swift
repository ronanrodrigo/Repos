import UIKit
import Shared

class DetailRepositoryTableViewCell: UITableViewCell {

    @IBOutlet weak var pullRequestTitle: UILabel!
    @IBOutlet weak var pullRequestBody: UILabel!
    @IBOutlet weak var pullRequestCreatedAt: UILabel!
    @IBOutlet weak var userAvatar: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var loadingImage: UIActivityIndicatorView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(pullRequest: PullRequest) {
        pullRequestTitle.text = pullRequest.title
        pullRequestBody.text = pullRequest.body
        userName.text = pullRequest.user.name

        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        pullRequestCreatedAt.text = dateFormatter.string(from: pullRequest.createdAt)
    }

    func configure(image: UIImage) {
        loadingImage.isHidden = true
        userAvatar.image = image
    }

    override func prepareForReuse() {
        loadingImage.isHidden = false
        userAvatar.image = nil
        isSelected = false
    }

}
