import Foundation

class ExpensesPresenter {

  private weak var view: ExpensesViewProtocol?
  private let router: ExpensesRouter
  private let repository: ExpensesRepository

  init(view: ExpensesViewProtocol, router: ExpensesRouter, repository: ExpensesRepository) {
    self.view = view
    self.router = router
    self.repository = repository
  }

  func hasExpenses() -> Bool {
    return (self.repository.numberOfExpenses() > 0)
  }

  func userTapAdd() {
    self.router.navigateToAddExpense(delegate: self)
  }

  func userTapChart() {
    self.router.navigateToExpensesByCategory()
  }
}

extension ExpensesPresenter: AddExpenseDelegate {
  
  func addExpenseDidSave(expense: Expense) {
    self.view?.reloadExpenses()
  }
}

extension ExpensesPresenter: DayExpenseListDelegate {
  
  func dayExpenseListDidSelectExpense(_ expense: Expense) {
    self.router.navigateToExpenseDetail(expense: expense, delegate: self)
  }
  
  func dayExpenseListDidDeleteExpense(_ expense: Expense) {
    self.view?.reloadExpenses()
  }
}

extension ExpensesPresenter: MonthExpenseListDelegate {
  
  func didSelectDay(_ expenseDay: ExpenseDay) {
    self.router.navigateToExpenseDayList(date: expenseDay.date, delegate: self)
  }
}

extension ExpensesPresenter: ExpenseListDelegate {

  func expenseListDidDeleteExpense(_ expense: Expense) {
    self.view?.reloadExpenses()
  }
}
