import UIKit

protocol AddExpenseDelegate: AnyObject {
  func addExpenseDidSave(expense: Expense)
}

class AddExpenseModuleBuilder {
  
  private let repository: ExpensesRepository
  private let categorySelectorModuleBuilder: CategorySelectorModuleBuilder
  
  init(
    repository: ExpensesRepository,
    categorySelectorModuleBuilder: CategorySelectorModuleBuilder
  ) {
    self.repository = repository
    self.categorySelectorModuleBuilder = categorySelectorModuleBuilder
  }
  
  func buildAddExpense(delegate: AddExpenseDelegate) -> UINavigationController? {
    let viewController = AddExpenseViewController()
    
    let router = AddExpenseRouter(
      viewController: viewController,
      categorySelectorModuleBuilder: self.categorySelectorModuleBuilder
    )
    
    viewController.presenter = AddExpensePresenter(
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
    
    let router = AddExpenseRouter(
      viewController: viewController,
      categorySelectorModuleBuilder: self.categorySelectorModuleBuilder
    )
    
    viewController.presenter = AddExpensePresenter(
      view: viewController,
      delegate: delegate,
      router: router,
      repository: self.repository,
      expense: expense
    )
    
    return UINavigationController(rootViewController: viewController)
  }
  
}
