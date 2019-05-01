import Foundation

struct Expense {
  let expenseId: String
  let name: String
  let amount: Int
  let createdAt: Date
}

protocol ExpensesRepository {
  func numberOfExpenses() -> Int
  func allExpenses() -> [Expense]
  
  func find(expenseId: String) -> Expense?
  func add(expense: Expense) -> Bool
  func delete(expense: Expense) -> Bool
  func update(expense: Expense) -> Bool
}
