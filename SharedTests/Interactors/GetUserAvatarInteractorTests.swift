import XCTest
@testable import Shared

class GetUserAvatarInteractorTests: XCTestCase {

    var interactor: GetUserAvatarInteractor!
    var gateway: UserGateway!
    var presenter: GetUserAvatarPresenterFake!
    var webService: WebServiceFake<Data>!

    override func setUp() {
        presenter = GetUserAvatarPresenterFake()
        webService = WebServiceFake()
        gateway = UserGateway(webService: webService)
        interactor = GetUserAvatarInteractor(userGateway: gateway, presenter: presenter)
        super.setUp()
    }

    func testNotShowImageWhenDataIsNone() {
        interactor.get(user: UserEntity(name: "", avatarUrl: URL(string: "http://some.url")))

        XCTAssertNil(presenter.showedImageData)
        XCTAssertNil(presenter.userWithAvatar)
    }

    func testNotShowImageWhenAvatarUrlIsNone() {
        interactor.get(user: UserEntity(name: "", avatarUrl: nil))

        XCTAssertNil(presenter.showedImageData)
        XCTAssertNil(presenter.userWithAvatar)
    }

    func testShowImageWhenAvatarDataIsSome() {
        webService.returnedEntity = Data()

        interactor.get(user: UserEntity(name: "", avatarUrl: URL(string: "http://some.url")))

        XCTAssertNotNil(presenter.showedImageData)
        XCTAssertNotNil(presenter.userWithAvatar)
    }

}
