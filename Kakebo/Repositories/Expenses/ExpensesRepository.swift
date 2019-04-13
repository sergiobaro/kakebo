import Foundation

struct Expense {
  
  let amount: String
  
}

class ExpensesRepository {
  
  private var expenses = [Expense]()
  
  func allExpenses() -> [Expense] {
    return self.expenses
  }
  
  func add(expense: Expense) {
    self.expenses.append(expense)
  }
}
