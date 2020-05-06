import Foundation

struct Expense {
  let expenseId: String
  let name: String
  let amount: Int
  let createdAt: Date
  var categories: [ExpenseCategory]
}

extension Expense: Comparable {
  static func == (lhs: Expense, rhs: Expense) -> Bool {
    return lhs.createdAt == rhs.createdAt
  }

  static func < (lhs: Expense, rhs: Expense) -> Bool {
    return lhs.createdAt < rhs.createdAt
  }
}

protocol ExpensesRepository {
  func numberOfExpenses() -> Int
  func allExpenses() -> [Expense]
  func find(expenseId: String) -> Expense?
  func findBetween(start: Date, end: Date) -> [Expense]
  
  func add(expense: Expense) -> Bool
  func delete(expense: Expense) -> Bool
  func update(expense: Expense) -> Bool
}
