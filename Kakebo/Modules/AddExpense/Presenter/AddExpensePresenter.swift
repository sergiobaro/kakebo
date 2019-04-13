import Foundation

class AddExpensePresenter {
  
  private let router: AddExpenseRouter
  private let repository: ExpensesRepository
  
  init(router: AddExpenseRouter, repository: ExpensesRepository) {
    self.router = router
    self.repository = repository
  }
  
  func userTapDone(text: String?) {
    if let amount = text {
      self.repository.add(expense: Expense(amount: amount))
    }
    
    self.router.navigateBack()
  }
  
  func userTapCancel() {
    self.router.navigateBack()
  }
}
