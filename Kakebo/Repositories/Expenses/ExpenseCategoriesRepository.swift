import Foundation

struct ExpenseCategory {
  let categoryId: String
  let name: String
}

extension ExpenseCategory: Equatable {
  static func == (lhs: ExpenseCategory, rhs: ExpenseCategory) -> Bool {
    lhs.categoryId == rhs.categoryId
  }
}

protocol ExpenseCategoriesRepository {
  func numberOfCategories() -> Int
  func allCategories() -> [ExpenseCategory]
  func find(categoryId: String) -> ExpenseCategory?

  func add(category: ExpenseCategory) -> Bool
  func delete(category: ExpenseCategory) -> Bool
  func update(category: ExpenseCategory) -> Bool
}
