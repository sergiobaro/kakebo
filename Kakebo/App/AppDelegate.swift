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
      let repository = try RealmExpensesRepositoryFactory.make()

      let addExpenseModuleBuilder = AddExpenseModuleBuilder(
        repository: repository,
        categorySelectorModuleBuilder: CategorySelectorModuleBuilder(repository: repository)
      )
      let expenseListModuleBuilder = ExpenseListModuleBuilder(repository: repository)
      let dateRangeSelectorModuleBuilder = DateRangeSelectorModuleBuilder(repository: repository)
      let expensesByCategoryModuleBuilder = ExpensesByCategoryModuleBuilder(
        expensesRepository: repository,
        categoriesRepository: repository,
        dateRangeSelectorModuleBuilder: dateRangeSelectorModuleBuilder
      )

      self.window!.rootViewController = ExpensesModuleBuilder(
        repository: repository,
        addExpenseModuleBuilder: addExpenseModuleBuilder,
        expenseListModuleBuilder: expenseListModuleBuilder,
        expensesByCategoryModuleBuilder: expensesByCategoryModuleBuilder
      ).build()
    } catch {
      print(error)
      fatalError()
    }
    
    self.window!.makeKeyAndVisible()
    
    return true
  }
  
}
