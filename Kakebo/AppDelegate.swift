import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    let expenses = ExpensesRepository()
    
    self.window = UIWindow(frame: UIScreen.main.bounds)
    self.window!.rootViewController = ExpensesModuleBuilder(repository: expenses).build()
    self.window!.makeKeyAndVisible()
    
    return true
  }
  
}
