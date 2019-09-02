import Foundation
import RealmSwift

class RealmExpensesRepositoryFactory {

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
}
