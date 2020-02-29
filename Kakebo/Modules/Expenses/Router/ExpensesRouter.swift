import UIKit

class ExpensesRouter {

  private weak var viewController: UIViewController?
  private let addExpenseModuleBuilder: AddExpenseModuleBuilder
  private let expenseListModuleBuilder: ExpenseListModuleBuilder

  init(
    viewController: UIViewController,
    addExpenseModuleBuilder: AddExpenseModuleBuilder,
    expenseListModuleBuilder: ExpenseListModuleBuilder
  ) {
    self.viewController = viewController
    self.addExpenseModuleBuilder = addExpenseModuleBuilder
    self.expenseListModuleBuilder = expenseListModuleBuilder
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
  
  func navigateToExpenseDayList(date: Date, delegate: ExpenseListDelegate) {
    if let expenseList = self.expenseListModuleBuilder.buildExpenseList(for: date, delegate: delegate) {
      self.viewController?.present(expenseList, animated: true)
    }
  }
}
