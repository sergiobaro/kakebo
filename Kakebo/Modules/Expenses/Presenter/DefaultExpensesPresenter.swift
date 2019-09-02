import Foundation

class DefaultExpensesPresenter {

  private let router: ExpensesRouter
  private let repository: ExpensesRepository

  init(router: ExpensesRouter, repository: ExpensesRepository) {
    self.router = router
    self.repository = repository
  }
}

extension DefaultExpensesPresenter: ExpensesPresenter {

  func hasExpenses() -> Bool {
    return (self.repository.numberOfExpenses() > 0)
  }

  func userTapAdd() {
    self.router.navigateToAddExpense()
  }
}
