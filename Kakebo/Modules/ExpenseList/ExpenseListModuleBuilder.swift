import UIKit

class ExpenseListModuleBuilder {
  
  func build(repository: ExpensesRepository) -> UIViewController? {
    let viewController = ExpenseListViewController()
    
    let router = ExpenseListRouter(
      viewController: viewController,
      addExpenseModuleBuilder: AddExpenseModuleBuilder(repository: repository)
    )

    viewController.presenter = DefaultExpenseListPresenter(
      router: router
    )

    return UINavigationController(rootViewController: viewController)
  }
  
}
