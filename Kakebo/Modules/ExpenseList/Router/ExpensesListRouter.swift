import UIKit

class ExpenseListRouter {

  private weak var viewController: UIViewController?
  private let addExpenseModuleBuilder: AddExpenseModuleBuilder

  init(viewController: UIViewController, addExpenseModuleBuilder: AddExpenseModuleBuilder) {
    self.viewController = viewController
    self.addExpenseModuleBuilder = addExpenseModuleBuilder
  }

  func navigateToAddExpense() {
    if let addExpense = self.addExpenseModuleBuilder.buildAddExpense() {
      self.viewController?.present(addExpense, animated: true)
    }
  }
  
  func navigateToExpenseDetail(expense: Expense) {
    if let expenseDetail = self.addExpenseModuleBuilder.buildEditExpense(expense: expense) {
      self.viewController?.present(expenseDetail, animated: true)
    }
  }
}
