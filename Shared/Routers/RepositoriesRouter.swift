public protocol RepositoriesRouter {
    func list()
    func detail(repository: Repository)
}
