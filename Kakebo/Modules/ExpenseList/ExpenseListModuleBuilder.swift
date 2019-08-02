import UIKit

class ExpenseListModuleBuilder {
  
  func build(repository: ExpensesRepository) -> UIViewController? {
    let viewController = ExpenseListViewController()
    
//    let router = ExpenseListRouter(
//      viewController: viewController,
//      addExpenseModuleBuilder: AddExpenseModuleBuilder(repository: repository)
//    )
    
//    viewController.presenter = DefaultExpenseDayListPresenter(
//      view: viewController,
//      router: router,
//      repository: repository
//    )

    return UINavigationController(rootViewController: viewController)
  }
  
}
