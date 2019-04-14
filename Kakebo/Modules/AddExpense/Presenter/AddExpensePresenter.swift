import Foundation

class AddExpensePresenter {
  
  private let router: AddExpenseRouter
  private let repository: ExpensesRepository
  
  init(router: AddExpenseRouter, repository: ExpensesRepository) {
    self.router = router
    self.repository = repository
  }
  
  func userTapDone(text: String?) {
    if let name = text {
      do {
        try self.repository.add(expense: Expense(name: name))
      } catch {
        print(error)
      }
    }
    
    self.router.navigateBack()
  }
  
  func userTapCancel() {
    self.router.navigateBack()
  }
}
