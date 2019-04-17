import Foundation

class DefaultExpensesPresenter {
  
  private let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .short
    dateFormatter.timeStyle = .none
    return dateFormatter
  }()
  
  private let numberFormatter: NumberFormatter = {
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .currency
    return numberFormatter
  }()

  private let router: ExpensesRouter
  private let repository: ExpensesRepository
  
  private var expenses = [Expense]()
  
  init(router: ExpensesRouter, repository: ExpensesRepository) {
    self.router = router
    self.repository = repository
  }
  
  // MARK: - Private
  
  private func map(expense: Expense) -> ExpenseViewModel {
    return ExpenseViewModel(
      name: expense.name,
      amount: self.map(amount: expense.amount),
      date: self.map(createdAt: expense.createdAt)
    )
  }
  
  private func map(amount: Int) -> String {
    let number = (Float(amount) / 100) as NSNumber
    return self.numberFormatter.string(from: number) ?? ""
  }
  
  private func map(createdAt date: Date) -> String {
    return self.dateFormatter.string(from: date)
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
  
  func expense(at index: Int) -> ExpenseViewModel? {
    return self.expenses.element(at: index).map(self.map(expense:))
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
