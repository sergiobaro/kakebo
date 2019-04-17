import Foundation
import RealmSwift

class ExpenseRealm: Object {
  
  @objc dynamic var expenseId = UUID().uuidString
  @objc dynamic var name = ""
  @objc dynamic var amount = 0
  @objc dynamic var createdAt = Date()
  
  override static func primaryKey() -> String? {
    return "expenseId"
  }
  
}

class RealmExpensesRepository {
  
  private let realm: Realm
  
  init(realm: Realm) {
    self.realm = realm
  }
  
  // MARK: - Private
  
  private func findExpense(expense: Expense) -> ExpenseRealm? {
    return self.realm.object(ofType: ExpenseRealm.self, forPrimaryKey: expense.expenseId)
  }
  
  private func map(expense: ExpenseRealm) -> Expense {
    return Expense(
      expenseId: expense.expenseId,
      name: expense.name,
      amount: expense.amount,
      createdAt: expense.createdAt
    )
  }
}

extension RealmExpensesRepository: ExpensesRepository {
  
  func numberOfExpenses() -> Int {
    return self.realm.objects(ExpenseRealm.self).count
  }
  
  func allExpenses() -> [Expense] {
    return self.realm.objects(ExpenseRealm.self)
      .sorted(byKeyPath: "createdAt", ascending: false)
      .map(self.map(expense:))
  }
  
  func add(expense: Expense) -> Bool {
    do {
      try self.realm.write {
        let newExpense = ExpenseRealm()
        newExpense.name = expense.name
        newExpense.amount = expense.amount
        realm.add(newExpense)
      }
      return true
    } catch {
      return false
    }
  }
  
  func delete(expense: Expense) -> Bool {
    guard let expense = self.findExpense(expense: expense) else {
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
