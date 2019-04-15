import Foundation

struct Expense {
  let name: String
  let amount: Int
}

protocol ExpensesRepository {
  func numberOfExpenses() -> Int
  func allExpenses() -> [Expense]
  func expense(at index: Int) -> Expense?
  func add(expense: Expense) -> Bool
  func deleteExpense(at index: Int) -> Bool
}
