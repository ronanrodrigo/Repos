import UIKit

struct User {
    var name: String
    var avatarUrl: URL?
}

struct Repository {
    var name: String
    var description: String
    var owner: User
    var stars: Int
    var forks: Int
}

struct PullRequest {
    var title: String
    var user: User
    var createdAt: Date
    var body: String
}

let user = User(
    name: "Facebook",
    avatarUrl: URL(string: "https://avatars.githubusercontent.com/u/66577?v=3"))

let repository = Repository(
    name: "Rective Native",
    description: "Shit",
    owner: user,
    stars: 10,
    forks: 10)

let pullRequest = PullRequest(
    title: "Title",
    user: user,
    createdAt: Date(),
    body: "Body")

dump(repository)
dump(pullRequest)
