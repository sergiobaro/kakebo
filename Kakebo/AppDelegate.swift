import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?

  // swiftlint:disable:next line_length
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    #if DEBUG
    if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil {
      return true
    }
    #endif

    UINavigationBar.appearance().tintColor = .black

    self.window = UIWindow(frame: UIScreen.main.bounds)

    do {
      let expensesRepository = try RealmExpensesRepository.make()
      self.window!.rootViewController = ExpensesListModuleBuilder().build(repository: expensesRepository)
    } catch {
      print(error)
      fatalError()
    }
    
    self.window!.makeKeyAndVisible()
    
    return true
  }
  
}
