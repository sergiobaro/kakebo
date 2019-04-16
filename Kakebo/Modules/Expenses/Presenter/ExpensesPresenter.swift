import Foundation

class DefaultExpensesPresenter {

  private let router: ExpensesRouter
  private let repository: ExpensesRepository
  
  private var expenses = [Expense]()
  
  init(router: ExpensesRouter, repository: ExpensesRepository) {
    self.router = router
    self.repository = repository
  }
  
}

extension DefaultExpensesPresenter: ExpensesPresenter {
  
  func viewReady() {
    // nop
  }
  
  func viewAppear() {
    self.expenses = self.repository.allExpenses()
  }
  
  func numberOfExpenses() -> Int {
    return self.expenses.count
  }
  
  func expense(at index: Int) -> Expense? {
    return self.expenses.element(at: index)
  }
  
  func deleteExpense(at index: Int) -> Bool {
    guard let expense = self.expenses.element(at: index) else {
      return false
    }
    guard self.repository.delete(expense: expense) else {
      return false
    }
    
    self.expenses = self.repository.allExpenses()
    
    return true
  }

  func userTapAdd() {
    self.router.navigateToAddExpense()
  }
}
