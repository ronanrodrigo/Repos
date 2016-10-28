import XCTest
@testable import Shared

class ListRepositoriesInteractorTests: XCTestCase {

    var interactor: ListRepositoriesInteractor!
    var presenter: ListRepositoriesPresenterFake!
    var gateway: RepositoriesGatewayFake!
    var webService: WebServiceFake!

    override func setUp() {
        webService = WebServiceFake()
        gateway = RepositoriesGatewayFake(webService: webService)
        presenter = ListRepositoriesPresenterFake()
        interactor = ListRepositoriesInteractor(gateway: gateway, presenter: presenter)
    }

    func testNotListRepositoriesWhenAnErrorOcurrs() {
        interactor.list()

        XCTAssertEqual(0, presenter.repositories.count)
        XCTAssertNotNil(presenter.errorMessage)
    }

}
