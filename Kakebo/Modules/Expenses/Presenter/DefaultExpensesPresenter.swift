import Foundation

class DefaultExpensesPresenter {

  private weak var view: ExpensesViewProtocol?
  private let router: ExpensesRouter
  private let repository: ExpensesRepository

  init(view: ExpensesViewProtocol, router: ExpensesRouter, repository: ExpensesRepository) {
    self.view = view
    self.router = router
    self.repository = repository
  }
}

extension DefaultExpensesPresenter: ExpensesPresenter {

  func hasExpenses() -> Bool {
    return (self.repository.numberOfExpenses() > 0)
  }

  func userTapAdd() {
    self.router.navigateToAddExpense(delegate: self)
  }
}

extension DefaultExpensesPresenter: AddExpenseDelegate {
  
  func addExpenseDidSave(expense: Expense) {
    self.view?.reloadExpenses()
  }
}

extension DefaultExpensesPresenter: ExpenseListDelegate {
  
  func didSelectExpense(_ expense: Expense) {
    self.router.navigateToExpenseDetail(expense: expense, delegate: self)
  }
}
