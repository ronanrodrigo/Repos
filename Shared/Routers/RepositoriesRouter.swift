public protocol RepositoriesRouter {
    func list()
    func detail(repository: Repository)
    func open(url: URL)
}
