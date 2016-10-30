import UIKit
import ChameleonFramework

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()

        let navigationController = UINavigationController()
        window?.rootViewController = navigationController

        RepositoriesRouterNavigation(navigationController: navigationController).list()

        Chameleon.setGlobalThemeUsingPrimaryColor(UIColor.flatMint(), with: .contrast)
        navigationController.hidesNavigationBarHairline = true
        navigationController.navigationBar.isTranslucent = false

        return true
    }

}
