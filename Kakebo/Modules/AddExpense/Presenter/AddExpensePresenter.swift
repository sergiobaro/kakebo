import Foundation

protocol AddExpenseView {
  
  func done(enabled: Bool)
  
}
  
class DefaultAddExpensePresenter {
  
  private let view: AddExpenseView
  private let router: AddExpenseRouter
  private let repository: ExpensesRepository
  
  init(view: AddExpenseView, router: AddExpenseRouter, repository: ExpensesRepository) {
    self.view = view
    self.router = router
    self.repository = repository
  }
}

extension DefaultAddExpensePresenter: AddExpensePresenter {
  
  func viewIsReady() {
    self.view.done(enabled: false)
  }
  
  func userTapDone(text: String?) {
    guard let name = text, !name.isEmpty else {
      return
    }
    
    if self.repository.add(expense: Expense(name: name)) {
      self.router.navigateBack()
    }
  }
  
  func userTapCancel() {
    self.router.navigateBack()
  }
  
  func userChangedName(text: String?) {
    let enabled = text != nil && !text!.isEmpty
    
    self.view.done(enabled: enabled)
  }
}
