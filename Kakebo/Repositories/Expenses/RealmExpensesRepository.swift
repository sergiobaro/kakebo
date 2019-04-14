import Foundation
import RealmSwift

class ExpenseRealm: Object {
  @objc dynamic var name = ""
}

class RealmExpensesRepository {
  
  private let realm: Realm
  
  init(realm: Realm) {
    self.realm = realm
  }
  
  // MARK: - Private
  
  private func findExpense(at index: Int) -> ExpenseRealm? {
    return self.realm.objects(ExpenseRealm.self)[index]
  }
}

extension RealmExpensesRepository: ExpensesRepository {
  
  func numberOfExpenses() -> Int {
    return self.realm.objects(ExpenseRealm.self).count
  }
  
  func allExpenses() -> [Expense] {
    let results = self.realm.objects(ExpenseRealm.self)
    return results.map({ Expense(name: $0.name) })
  }
  
  func expense(at index: Int) -> Expense? {
    return self.findExpense(at: index).map({ Expense(name: $0.name) })
  }
  
  func add(expense: Expense) -> Bool {
    do {
      try self.realm.write {
        let newExpense = ExpenseRealm()
        newExpense.name = expense.name
        realm.add(newExpense)
      }
      return true
    } catch {
      return false
    }
  }
  
  func deleteExpense(at index: Int) -> Bool {
    guard let expense = self.findExpense(at: index) else {
      return false
    }
    
    do {
      try self.realm.write {
        self.realm.delete(expense)
      }
      return true
    } catch {
      return false
    }
  }
}
