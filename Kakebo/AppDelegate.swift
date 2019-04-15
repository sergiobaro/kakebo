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
      let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
      let realm = try Realm(configuration: config)
      
      let expensesRepository = RealmExpensesRepository(realm: realm)
      self.window!.rootViewController = ExpensesModuleBuilder(repository: expensesRepository).build()
    } catch {
      print(error)
      fatalError()
    }
    
    self.window!.makeKeyAndVisible()
    
    return true
  }
  
}
