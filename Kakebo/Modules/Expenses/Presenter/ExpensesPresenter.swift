import Foundation

class ExpensesPresenter {

  private let router: ExpensesRouter
  private let repository: ExpensesRepository
  
  init(router: ExpensesRouter, repository: ExpensesRepository) {
    self.router = router
    self.repository = repository
  }
  
  func numberOfExpenses() -> Int {
    return self.repository.numberOfExpenses()
  }
  
  func expense(at index: Int) -> Expense? {
    return self.repository.expense(at: index)
  }
  
  func deleteExpense(at index: Int) -> Bool {
    return self.repository.deleteExpense(at: index)
  }

  func userTapAdd() {
    self.router.navigateToAddExpense()
  }
}
