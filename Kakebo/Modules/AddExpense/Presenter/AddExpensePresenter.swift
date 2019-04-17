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
    let enabled = self.isValid(name: name, amount: amount)
    self.view?.done(enabled: enabled)
  }
  
  private func isValid(name: String?, amount: String?) -> Bool {
    return (self.expense(name: name, amount: amount) != nil)
  }
  
  private func expense(name: String?, amount: String?) -> Expense? {
    guard
      let name = name?.trimmingCharacters(in: .whitespaces),
      !name.isEmpty,
      let amount = amount.flatMap({ Int($0) })
      else {
        return nil
    }
    
    return Expense(
      expenseId: UUID().uuidString,
      name: name,
      amount: amount,
      createdAt: Date()
    )
  }
  
  private func currentExpense() -> Expense? {
    return self.expense(
      name: self.view?.currentName(),
      amount: self.view?.currentAmount()
    )
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
    
    return (amount != nil && (amount!.isEmpty || Int(amount!) != nil))
  }
}
