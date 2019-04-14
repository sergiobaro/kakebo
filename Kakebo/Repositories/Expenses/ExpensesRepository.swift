import Foundation

struct Expense {
  let name: String
}

protocol ExpensesRepository {
  func numberOfExpenses() -> Int
  func allExpenses() -> [Expense]
  func expense(at index: Int) -> Expense?
  func add(expense: Expense) throws
  func deleteExpense(at index: Int) throws -> Bool
}
