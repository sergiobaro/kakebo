import Foundation
import RealmSwift

class ExpenseRealm: Object {
  
  @objc dynamic var expenseId = UUID().uuidString
  @objc dynamic var name = ""
  @objc dynamic var amount = 0
  @objc dynamic var createdAt = Date()
  dynamic var categories = List<CategoryRealm>()
  
  override static func primaryKey() -> String? { "expenseId" }
}

class CategoryRealm: Object {

  @objc dynamic var categoryId = UUID().uuidString
  @objc dynamic var name = ""

  override class func primaryKey() -> String? { "categoryId" }
}

class RealmExpensesRepository {
  
  private let realm: Realm
  
  init(realm: Realm) {
    self.realm = realm
  }
  
  // MARK: - Private
  
  private func find(expense: Expense) -> ExpenseRealm? {
    return self.realm.object(ofType: ExpenseRealm.self, forPrimaryKey: expense.expenseId)
  }
  
  private func map(expense: ExpenseRealm) -> Expense {
    Expense(
      expenseId: expense.expenseId,
      name: expense.name,
      amount: expense.amount,
      createdAt: expense.createdAt,
      categories: expense.categories.map(self.map(category:))
    )
  }

  private func map(category: CategoryRealm) -> ExpenseCategory {
    ExpenseCategory(
      categoryId: category.categoryId,
      name: category.name
    )
  }

  private func findOrCreate(category: ExpenseCategory) -> CategoryRealm {
    if let categoryRealm = self.find(category: category) {
      return categoryRealm
    }

    let categoryRealm = CategoryRealm()
    categoryRealm.name = category.name
    categoryRealm.categoryId = category.categoryId
    return categoryRealm
  }

  private func find(category: ExpenseCategory) -> CategoryRealm? {
    self.realm.object(ofType: CategoryRealm.self, forPrimaryKey: category.categoryId)
  }
}

extension RealmExpensesRepository: ExpensesRepository {
  
  func numberOfExpenses() -> Int {
    self.realm.objects(ExpenseRealm.self).count
  }
  
  func allExpenses() -> [Expense] {
    self.realm
      .objects(ExpenseRealm.self)
      .sorted(byKeyPath: "createdAt", ascending: false)
      .map(self.map(expense:))
  }
  
  func find(expenseId: String) -> Expense? {
    self.realm
      .object(ofType: ExpenseRealm.self, forPrimaryKey: expenseId)
      .map(self.map(expense:))
  }

  func findBetween(start: Date, end: Date) -> [Expense] {
    self.realm
      .objects(ExpenseRealm.self)
      .filter("createdAt BETWEEN %@", [start, end])
      .map(self.map(expense:))
  }
  
  func add(expense: Expense) -> Bool {
    do {
      try self.realm.write {
        let expenseRealm = ExpenseRealm()
        
        expenseRealm.expenseId = expense.expenseId
        expenseRealm.name = expense.name
        expenseRealm.amount = expense.amount
        expenseRealm.createdAt = expense.createdAt
        expense.categories.forEach {
          let categoryRealm = self.findOrCreate(category: $0)
          expenseRealm.categories.append(categoryRealm)
        }
        
        realm.add(expenseRealm)
      }
      return true
    } catch {
      return false
    }
  }
  
  func delete(expense: Expense) -> Bool {
    guard let expense = self.find(expense: expense) else {
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
    guard let expenseRealm = self.find(expense: expense) else {
      return false
    }
    
    do {
      try self.realm.write {
        expenseRealm.name = expense.name
        expenseRealm.amount = expense.amount
        expenseRealm.createdAt = expense.createdAt
        expenseRealm.categories.removeAll()
        expense.categories.forEach {
          let categoryRealm = self.findOrCreate(category: $0)
          expenseRealm.categories.append(categoryRealm)
        }
      }
      return true
    } catch {
      return false
    }
  }
}

extension RealmExpensesRepository: ExpenseCategoriesRepository {

  func numberOfCategories() -> Int {
    self.realm.objects(CategoryRealm.self).count
  }

  func allCategories() -> [ExpenseCategory] {
    self.realm
      .objects(CategoryRealm.self)
      .sorted(byKeyPath: "name", ascending: true)
      .map(self.map(category:))
  }

  func find(categoryId: String) -> ExpenseCategory? {
    self.realm
      .object(ofType: CategoryRealm.self, forPrimaryKey: categoryId)
      .map(self.map(category:))
  }

  func add(category: ExpenseCategory) -> Bool {
    do {
      try self.realm.write {
        let categoryRealm = CategoryRealm()
        categoryRealm.name = category.name
        categoryRealm.categoryId = category.categoryId

        realm.add(categoryRealm)
      }
      return true
    } catch {
      return false
    }
  }

  func delete(category: ExpenseCategory) -> Bool {
    guard let categoryRealm = self.find(category: category) else {
      return false
    }

    do {
      try self.realm.write {
        self.realm.delete(categoryRealm)
      }
      return true
    } catch {
      return false
    }
  }

  func update(category: ExpenseCategory) -> Bool {
    guard let categoryRealm = self.find(category: category) else {
      return false
    }
    do {
      try self.realm.write {
        categoryRealm.name = category.name
      }
      return true
    } catch {
      return false
    }
  }
}
