import UIKit

class ExpenseListModuleBuilder {
  
  func build(repository: ExpensesRepository) -> UIViewController? {
    let viewController = ExpenseListViewController()
    
    let router = ExpenseListRouter(
      viewController: viewController,
      addExpenseModuleBuilder: AddExpenseModuleBuilder(repository: repository)
    )

    viewController.presenter = DefaultExpenseListPresenter(
      router: router,
      repository: repository
    )

    viewController.dayListViewController = ExpenseDayListModuleBuilder().make(
      router: router,
      repository: repository
    )

    viewController.monthListViewController = ExpenseDayListModuleBuilder().make(
      router: router,
      repository: repository
    )
    
    return UINavigationController(rootViewController: viewController)
  }
  
}
