import UIKit

protocol AddExpenseDelegate: class {
  func addExpenseDidSave(expense: Expense)
}

class AddExpenseModuleBuilder {
  
  private let repository: ExpensesRepository
  
  init(repository: ExpensesRepository) {
    self.repository = repository
  }
  
  func buildAddExpense(delegate: AddExpenseDelegate) -> UINavigationController? {
    let viewController = AddExpenseViewController()
    
    let router = AddExpenseRouter(viewController: viewController)
    
    viewController.presenter = DefaultAddExpensePresenter(
      view: viewController,
      delegate: delegate,
      router: router,
      repository: self.repository,
      expense: nil
    )
    
    return UINavigationController(rootViewController: viewController)
  }
  
  func buildEditExpense(expense: Expense, delegate: AddExpenseDelegate) -> UINavigationController? {
    let viewController = AddExpenseViewController()
    
    let router = AddExpenseRouter(viewController: viewController)
    
    viewController.presenter = DefaultAddExpensePresenter(
      view: viewController,
      delegate: delegate,
      router: router,
      repository: self.repository,
      expense: expense
    )
    
    return UINavigationController(rootViewController: viewController)
  }
  
}
