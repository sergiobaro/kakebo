import Foundation

class ExpensesPresenter {

  private let router: ExpensesRouter
  private let repository: ExpensesRepository
  
  init(router: ExpensesRouter, repository: ExpensesRepository) {
    self.router = router
    self.repository = repository
  }
  
  func numberOfExpenses() -> Int {
    return self.repository.allExpenses().count
  }
  
  func expense(at index: Int) -> Expense? {
    return self.repository.allExpenses()[index]
  }

  func userTapAdd() {
    self.router.navigateToAddExpense()
  }
}
