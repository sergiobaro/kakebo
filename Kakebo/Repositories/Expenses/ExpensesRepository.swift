import Foundation

struct Expense {
  let name: String
  let amount: Int
  let createdAt: Date
}

protocol ExpensesRepository {
  func numberOfExpenses() -> Int
  func allExpenses() -> [Expense]
  func add(expense: Expense) -> Bool
  func delete(expense: Expense) -> Bool
}
