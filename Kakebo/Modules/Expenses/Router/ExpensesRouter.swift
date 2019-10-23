import UIKit

class ExpensesRouter {

  private weak var viewController: UIViewController?
  private let addExpenseModuleBuilder: AddExpenseModuleBuilder

  init(
    viewController: UIViewController,
    addExpenseModuleBuilder: AddExpenseModuleBuilder
  ) {
    self.viewController = viewController
    self.addExpenseModuleBuilder = addExpenseModuleBuilder
  }

  func navigateToAddExpense(delegate: AddExpenseDelegate) {
    if let addExpense = self.addExpenseModuleBuilder.buildAddExpense(delegate: delegate) {
      self.viewController?.present(addExpense, animated: true)
    }
  }
  
  func navigateToExpenseDetail(expense: Expense, delegate: AddExpenseDelegate) {
    if let expenseDetail = self.addExpenseModuleBuilder.buildEditExpense(expense: expense, delegate: delegate) {
      self.viewController?.present(expenseDetail, animated: true)
    }
  }
}
