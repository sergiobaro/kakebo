import Foundation

protocol AddExpenseView: class {
  
  func done(enabled: Bool)
  func currentName() -> String?
  func currentAmount() -> String?
  
}

class DefaultAddExpensePresenter {
  
  private weak var view: AddExpenseView?
  private let router: AddExpenseRouter
  private let repository: ExpensesRepository
  
  init(view: AddExpenseView, router: AddExpenseRouter, repository: ExpensesRepository) {
    self.view = view
    self.router = router
    self.repository = repository
  }
  
  // MARK: - Private
  
  private func valuesChanged(name: String?, amount: String?) {
    var enabled = false
    if self.expense(name: name, amount: amount) != nil {
      enabled = true
    }
    
    self.view?.done(enabled: enabled)
  }
  
  private func expense(name: String?, amount: String?) -> Expense? {
    guard
      let name = name,
      let amountString = amount,
      !name.isEmpty,
      let amount = Int(amountString)
      else {
        return nil
    }
    
    return Expense(name: name, amount: amount)
  }
  
  private func currentExpense() -> Expense? {
    guard
      let name = self.view?.currentName(),
      let amount = self.view?.currentAmount()
      else {
        return nil
    }
    
    return self.expense(name: name, amount: amount)
  }
}

extension DefaultAddExpensePresenter: AddExpensePresenter {
  
  func viewIsReady() {
    self.view?.done(enabled: false)
  }
  
  func userTapDone() {
    guard let expense = self.currentExpense() else {
      return
    }
    
    if self.repository.add(expense: expense) {
      self.router.navigateBack()
    }
  }
  
  func userTapCancel() {
    self.router.navigateBack()
  }
  
  func userChanged(name: String?) -> Bool {
    self.valuesChanged(name: name, amount: self.view?.currentAmount())
    
    return (name != nil && name!.count <= 20)
  }
  
  func userChanged(amount: String?) -> Bool {
    self.valuesChanged(name: self.view?.currentName(), amount: amount)
    
    return (amount != nil && Int(amount!) != nil)
  }
}
