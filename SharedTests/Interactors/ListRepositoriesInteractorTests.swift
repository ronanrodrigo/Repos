import XCTest
@testable import Shared

class ListRepositoriesInteractorTests: XCTestCase {

    var interactor: ListRepositoriesInteractor!
    var presenter: ListRepositoriesPresenterFake!
    var gateway: RepositoriesGateway!
    var webService: WebServiceFake<[Repository]>!

    override func setUp() {
        webService = WebServiceFake()
        gateway = RepositoriesGateway(webService: webService)
        presenter = ListRepositoriesPresenterFake()
        interactor = ListRepositoriesInteractor(gateway: gateway, presenter: presenter)
    }

    func testNotListRepositoriesWhenAnErrorOcurrs() {
        webService.error = ErrorFake.error

        interactor.list()

        XCTAssertEqual(0, presenter.repositories.count)
        XCTAssertNotNil(presenter.errorMessage)
    }

    func testListRepositoriesWhenHasRepositories() {
        let user = UserEntity(name: "", avatarUrl: URL(string: "http://www.com.com"))
        webService.returnedEntity = [RepositoryEntity(name: "", description: "", owner: user, stars: 1, forks: 1)]

        interactor.list()

        XCTAssertTrue(presenter.repositories.count > 0)
        XCTAssertNil(presenter.errorMessage)
    }

    func testDisplayErrorWheWithoutRepositoriesAndWithoutRequestError() {
        interactor.list()

        XCTAssertEqual(0, presenter.repositories.count)
        XCTAssertNotNil(presenter.errorMessage)
    }

}
