import UIKit

class AddExpenseModuleBuilder {
  
  private let repository: ExpensesRepository
  
  init(repository: ExpensesRepository) {
    self.repository = repository
  }
  
  func buildAddExpense() -> UINavigationController? {
    let viewController = AddExpenseViewController()
    
    let router = AddExpenseRouter(viewController: viewController)
    
    viewController.presenter = DefaultAddExpensePresenter(
      view: viewController,
      router: router,
      repository: self.repository,
      expense: nil
    )
    
    return UINavigationController(rootViewController: viewController)
  }
  
  func buildEditExpense(expense: Expense) -> UINavigationController? {
    let viewController = AddExpenseViewController()
    
    let router = AddExpenseRouter(viewController: viewController)
    
    viewController.presenter = DefaultAddExpensePresenter(
      view: viewController,
      router: router,
      repository: self.repository,
      expense: expense
    )
    
    return UINavigationController(rootViewController: viewController)
  }
  
}
