import Foundation

class DefaultExpenseListPresenter {

  private let router: ExpenseListRouter
  private let repository: ExpensesRepository

  init(router: ExpenseListRouter, repository: ExpensesRepository) {
    self.router = router
    self.repository = repository
  }
}

extension DefaultExpenseListPresenter: ExpenseListPresenter {

  func hasExpenses() -> Bool {
    return (self.repository.numberOfExpenses() > 0)
  }

  func userTapAdd() {
    self.router.navigateToAddExpense()
  }
}
