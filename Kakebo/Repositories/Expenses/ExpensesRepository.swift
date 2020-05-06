import Foundation

struct Expense {
  let expenseId: String
  let name: String
  let amount: Int
  let createdAt: Date
  var categories: [ExpenseCategory]
}

struct ExpenseCategory {
  let categoryId: String
  let name: String
}

extension ExpenseCategory: Equatable {

  static func == (lhs: ExpenseCategory, rhs: ExpenseCategory) -> Bool {
    lhs.categoryId == rhs.categoryId
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

  func allCategories() -> [ExpenseCategory]
  func addCategory(_ category: ExpenseCategory) -> Bool
}
