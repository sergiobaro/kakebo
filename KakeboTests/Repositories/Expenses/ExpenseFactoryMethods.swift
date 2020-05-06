import Foundation
@testable import Kakebo

extension Expense {
  static func with(expenseId: String? = nil, name: String, createdAt: Date = Date(), categories: [ExpenseCategory] = []) -> Expense {
    Expense(
      expenseId: expenseId ?? UUID().uuidString,
      name: name,
      amount: 0,
      createdAt: createdAt,
      categories: categories
    )
  }
}

extension ExpenseCategory {
  static func with(name: String) -> ExpenseCategory {
    ExpenseCategory(categoryId: UUID().uuidString, name: name)
  }
}
