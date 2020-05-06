import Foundation
import RealmSwift

class RealmExpensesRepositoryFactory {

  private static let currentSchemaVersion: UInt64 = 3

  static func make() throws -> ExpensesRepository & ExpenseCategoriesRepository {
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
        case 2:
          migration.enumerateObjects(ofType: ExpenseRealm.className()) { _, newExpense in
            newExpense!["categories"] = List<CategoryRealm>()
          }
        default:
          break
        }
    })

    let realm = try Realm(configuration: config)
    return RealmExpensesRepository(realm: realm)
  }
}
