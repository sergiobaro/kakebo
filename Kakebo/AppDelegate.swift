import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    self.window = UIWindow(frame: UIScreen.main.bounds)
    
    do {
      let realm = try Realm()
      let expensesRepository = RealmExpensesRepository(realm: realm)
      self.window!.rootViewController = ExpensesModuleBuilder(repository: expensesRepository).build()
    } catch {
      fatalError()
    }
    
    self.window!.makeKeyAndVisible()
    
    return true
  }
  
}
