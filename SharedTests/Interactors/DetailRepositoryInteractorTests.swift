import XCTest
@testable import Shared

class DetailRepositoryInteractorTests: XCTestCase {

    var interactor: DetailRepositoryInteractor!
    var gateway: PullRequestsGateway!
    var presenter: DetailRepositoryPresenterFake!
    var webService: WebServiceFake<[PullRequest]>!
    var user: User!
    var repository: Repository!

    override func setUp() {
        webService = WebServiceFake()
        gateway = PullRequestsGateway(webService: webService)
        presenter = DetailRepositoryPresenterFake()
        interactor = DetailRepositoryInteractor(gateway: gateway, presenter: presenter)

        user = UserEntity(name: "", avatarUrl: URL(string: "http://some.url"))
        repository = RepositoryEntity(name: "", description: "", owner: user, stars: 1, forks: 1)

        super.setUp()
    }

    func testNotListPullRequestsWhenAnErrorOcurrs() {
        webService.error = ErrorFake.error

        interactor.detail(repository: repository)

        XCTAssertNil(presenter.listedPullRequests)
        XCTAssertNotNil(presenter.displayedError)
    }

    func testListPullRequestsWhenHasPullRequests() {
        webService.returnedEntity = [PullRequestEntity(title: "Title", user: user, createdAt: Date(), body: "Body")]

        interactor.detail(repository: repository)

        XCTAssertNotNil(presenter.listedPullRequests)
        XCTAssertNil(presenter.displayedError)
    }

    func testDisplayErrorWheWithoutPullRequestsAndWithoutRequestError() {
        interactor.detail(repository: repository)

        XCTAssertNil(presenter.listedPullRequests)
        XCTAssertNotNil(presenter.displayedError)
    }

}
