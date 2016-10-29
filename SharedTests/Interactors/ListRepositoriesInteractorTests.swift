import XCTest
@testable import Shared

class ListRepositoriesInteractorTests: XCTestCase {

    var interactor: ListRepositoriesInteractor!
    var presenter: ListRepositoriesPresenterFake!
    var gateway: RepositoriesGatewayFake!
    var webService: WebServiceFake<[Repository]>!
    var user: User!
    var repository: Repository!

    override func setUp() {
        webService = WebServiceFake()
        gateway = RepositoriesGatewayFake(webService: webService)
        presenter = ListRepositoriesPresenterFake()
        interactor = ListRepositoriesInteractor(gateway: gateway, presenter: presenter)
        user = UserEntity(
            name: "Facebook",
            avatarUrl: URL(string: "https://avatars.githubusercontent.com/u/66577?v=3"))
        repository = RepositoryEntity(
            name: "Rective Native",
            description: "Shit",
            owner: user,
            stars: 10,
            forks: 10)
    }

    func testNotListRepositoriesWhenAnErrorOcurrs() {
        webService.error = ErrorFake.error

        interactor.list()

        XCTAssertEqual(0, presenter.repositories.count)
        XCTAssertNotNil(presenter.errorMessage)
    }

    func testListRepositoriesWhenHasRepositories() {
        webService.returnedEntity = [repository]
        
        interactor.list()

        XCTAssertTrue(presenter.repositories.count > 0)
        XCTAssertNil(presenter.errorMessage)
    }

}
