import UIKit

class ExpensesListRouter {

  private weak var viewController: UIViewController?
  private let addExpensesModuleBuilder: AddExpenseModuleBuilder

  init(viewController: UIViewController, addExpensesModuleBuilder: AddExpenseModuleBuilder) {
    self.viewController = viewController
    self.addExpensesModuleBuilder = addExpensesModuleBuilder
  }

  func navigateToAddExpense() {
    if let addExpense = self.addExpensesModuleBuilder.buildAddExpense() {
      self.viewController?.present(addExpense, animated: true)
    }
  }
  
  func navigateToExpenseDetail(expense: Expense) {
    if let expenseDetail = self.addExpensesModuleBuilder.buildEditExpense(expense: expense) {
      self.viewController?.present(expenseDetail, animated: true)
    }
  }
}
