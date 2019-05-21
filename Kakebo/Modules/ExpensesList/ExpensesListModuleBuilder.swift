import UIKit

class ExpensesListModuleBuilder {
  
  func build(repository: ExpensesRepository) -> UIViewController? {
    let viewController = ExpensesListViewController()
    
    let router = ExpensesListRouter(
      viewController: viewController,
      addExpensesModuleBuilder: AddExpenseModuleBuilder(repository: repository)
    )
    
    viewController.presenter = DefaultExpensesListPresenter(
      view: viewController,
      router: router,
      repository: repository
    )
    
    return UINavigationController(rootViewController: viewController)
  }
  
}
