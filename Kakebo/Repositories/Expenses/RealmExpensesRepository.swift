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
  
  private static let currentSchemaVersion: UInt64 = 2
  
  static func make() throws -> ExpensesRepository {
    let config = Realm.Configuration(
      schemaVersion: self.currentSchemaVersion,
      migrationBlock: { migration, oldSchemaVersion in
        switch oldSchemaVersion {
        case 0:
          // nothing to migrate
          break
        case 1:
          migration.enumerateObjects(ofType: ExpenseRealm.className(), { _, newExpense in
            newExpense!["expenseId"] = UUID().uuidString
          })
        default:
          break
        }
      }
    )
    
    let realm = try Realm(configuration: config)
    return RealmExpensesRepository(realm: realm)
  }
  
  private let realm: Realm
  
  private init(realm: Realm) {
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
        newExpense.createdAt = expense.createdAt
        
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
  
  func update(expense: Expense) -> Bool {
    guard let expenseRealm = self.findExpense(expense: expense) else {
      return false
    }
    
    do {
      try self.realm.write {
        expenseRealm.name = expense.name
        expenseRealm.amount = expense.amount
        expenseRealm.createdAt = expense.createdAt
      }
      return true
    } catch {
      return false
    }
  }
}
