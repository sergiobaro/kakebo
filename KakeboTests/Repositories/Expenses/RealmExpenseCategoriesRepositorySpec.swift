import Quick
import Nimble
import RealmSwift

@testable import Kakebo

class RealmExpenseCategoriesRepositorySpec: QuickSpec {
  override func spec() {

    var realm: Realm!
    var repository: RealmExpensesRepository!

    beforeEach {
      realm = try! Realm(configuration: .init(inMemoryIdentifier: String(describing: self)))
      repository = RealmExpensesRepository(realm: realm)
    }
    afterEach {
      try! realm.write {
        realm.deleteAll()
      }
    }

    context("with categories") {
      it("when saving a category") {
        let category = ExpenseCategory.with(name: "Test")
        let result = repository.add(category: category)

        expect(result).to(beTrue())

        let categories = repository.allCategories()
        expect(categories.count).to(equal(1))
        expect(categories.first?.name).to(equal(category.name))
        expect(categories.first?.categoryId).to(equal(category.categoryId))
      }
      it("when deleting a category that doesn't exist") {
        let category = ExpenseCategory.with(name: "Test")

        let result = repository.delete(category: category)

        expect(result).to(beFalse())
      }
      it("when deleting a category that exists") {
        let category = ExpenseCategory.with(name: "Test")
        _ = repository.add(category: category)

        let result = repository.delete(category: category)

        expect(result).to(beTrue())
      }
      it("when counting categories") {
        expect(repository.numberOfCategories()).to(equal(0))

        let category = ExpenseCategory.with(name: "Test")
        _ = repository.add(category: category)

        expect(repository.numberOfCategories()).to(equal(1))
      }
      it("when updating a category that doesn't exist") {
        let category = ExpenseCategory.with(name: "Test")

        let result = repository.update(category: category)

        expect(result).to(beFalse())
      }
      it("when updating a category that exists") {
        let category = ExpenseCategory.with(name: "Name")
        _ = repository.add(category: category)

        let newCategory = ExpenseCategory(categoryId: category.categoryId, name: "NewName")
        let result = repository.update(category: newCategory)

        expect(result).to(beTrue())

        let foundCategory = repository.find(categoryId: category.categoryId)
        expect(foundCategory?.name).to(equal("NewName"))
      }
    }

    context("expense with categories") {
      it("when saving an expense with categories") {
        let category = ExpenseCategory.with(name: "Category")
        let expense = Expense.with(name: "Expense", categories: [category])

        _ = repository.add(expense: expense)

        let result = repository.find(expenseId: expense.expenseId)
        expect(result?.categories.count).to(equal(1))

        expect(repository.find(categoryId: category.categoryId)).toNot(beNil())
      }
      it("when fetching all expenses should fetch the categories") {
        let category = ExpenseCategory.with(name: "Category")
        let expense = Expense.with(name: "Expense", categories: [category])

        _ = repository.add(expense: expense)
        let result = repository.allExpenses()
        expect(result.first?.categories.count).to(equal(1))
      }
      it("when finding an expense should fetch the categories") {
        let category = ExpenseCategory.with(name: "Category")
        let expense = Expense.with(name: "Expense", categories: [category])

        _ = repository.add(expense: expense)
        let result = repository.find(expenseId: expense.expenseId)
        expect(result?.categories.count).to(equal(1))
      }
    }

    context("when updating an expense with categories") {
      it("when a category is added to the expense") {
        let category = ExpenseCategory.with(name: "Category")
        let expense = Expense.with(name: "Expense", categories: [category])
        _ = repository.add(expense: expense)

        let newCategory = ExpenseCategory.with(name: "NewCategory")
        let newExpense = Expense.with(expenseId: expense.expenseId, name: expense.name, categories: [category, newCategory])

        let result = repository.update(expense: newExpense)
        expect(result).to(beTrue())

        let foundExpense = repository.find(expenseId: expense.expenseId)
        expect(foundExpense?.categories.count).to(equal(2))
      }

      it("when a category is removed") {
        let category = ExpenseCategory.with(name: "Category")
        let expense = Expense.with(name: "Expense", categories: [category])
        _ = repository.add(expense: expense)

        let newExpense = Expense.with(expenseId: expense.expenseId, name: expense.name, categories: [])

        let result = repository.update(expense: newExpense)
        expect(result).to(beTrue())

        let foundExpense = repository.find(expenseId: expense.expenseId)
        expect(foundExpense?.categories.count).to(equal(0))
      }
      it("when a category is replaced") {
        let category = ExpenseCategory.with(name: "Category")
        let expense = Expense.with(name: "Expense", categories: [category])
        _ = repository.add(expense: expense)

        let newCategory = ExpenseCategory.with(name: "NewCategory")
        let newExpense = Expense.with(expenseId: expense.expenseId, name: expense.name, categories: [newCategory])

        let result = repository.update(expense: newExpense)
        expect(result).to(beTrue())

        let foundExpense = repository.find(expenseId: expense.expenseId)
        expect(foundExpense?.categories.count).to(equal(1))
        expect(foundExpense?.categories.first?.name).to(equal(newCategory.name))
      }
    }
  }
}
