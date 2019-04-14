import Foundation
import RealmSwift

class ExpenseRealm: Object {
  @objc dynamic var name = ""
}

struct Expense {
  
  let name: String
  
}

class ExpensesRepository {
  
  private let realm: Realm?
  
  init() {
    self.realm = try? Realm()
  }
  
  func numberOfExpenses() -> Int {
    guard let count = self.realm?.objects(ExpenseRealm.self).count else {
      return 0
    }
    
    return count
  }
  
  func allExpenses() -> [Expense] {
    guard let results = self.realm?.objects(ExpenseRealm.self) else {
      return []
    }
    
    return results.map({ Expense(name: $0.name) })
  }
  
  func expense(at index: Int) -> Expense? {
    return self.findExpense(at: index).map({ Expense(name: $0.name) })
  }
  
  func add(expense: Expense) throws {
    try self.realm?.write {
      let newExpense = ExpenseRealm()
      
      newExpense.name = expense.name
      
      realm?.add(newExpense)
    }
  }
  
  func deleteExpense(at index: Int) throws -> Bool {
    guard let expense = self.findExpense(at: index) else {
      return false
    }
    
    try self.realm?.write {
      self.realm?.delete(expense)
    }
    return true
  }
  
  private func findExpense(at index: Int) -> ExpenseRealm? {
    return self.realm?.objects(ExpenseRealm.self)[index]
  }
}
