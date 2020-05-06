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

    Style.applyApperance()

    self.window = UIWindow(frame: UIScreen.main.bounds)

    do {
      let expensesRepository = try RealmExpensesRepositoryFactory.make()
      let addExpenseModuleBuilder = AddExpenseModuleBuilder(
        repository: expensesRepository,
        categorySelectorModuleBuilder: CategorySelectorModuleBuilder(repository: expensesRepository)
      )
      let expenseListModuleBuilder = ExpenseListModuleBuilder(repository: expensesRepository)
      self.window!.rootViewController = ExpensesModuleBuilder(
        repository: expensesRepository,
        addExpenseModuleBuilder: addExpenseModuleBuilder,
        expenseListModuleBuilder: expenseListModuleBuilder
      ).build()
    } catch {
      print(error)
      fatalError()
    }
    
    self.window!.makeKeyAndVisible()
    
    return true
  }
  
}
