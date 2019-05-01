import Quick
import Nimble
import RealmSwift

@testable import Kakebo

class RealmExpensesRepositorySpec: QuickSpec {
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
    
    it("when is empty") {
      expect(repository.numberOfExpenses()).to(equal(0))
      expect(repository.allExpenses().isEmpty).to(beTrue())
    }
    
    it("when add expense") {
      let expense = Expense(expenseId: "1", name: "name", amount: 10, createdAt: Date())
      
      let result = repository.add(expense: expense)
      
      expect(result).to(beTrue())
      expect(repository.numberOfExpenses()).to(equal(1))
    }
    
    context("when find expense") {
      it("when it doesn't exist should return nil") {
        let expense = repository.find(expenseId: "1")
        
        expect(expense).to(beNil())
      }
      it("when exists should return the right expense") {
        let expense = Expense(expenseId: "1", name: "name", amount: 10, createdAt: Date())
        _ = repository.add(expense: expense)
        
        let result = repository.find(expenseId: expense.expenseId)
        
        expect(result).toNot(beNil())
      }
    }
    
    context("when delete expense") {
      it("when it doesn't exist should return false") {
        let expense = Expense(expenseId: "1", name: "name", amount: 10, createdAt: Date())
        
        let result = repository.delete(expense: expense)
        
        expect(result).to(beFalse())
      }
      it("when is deleted should return true") {
        let expense = Expense(expenseId: "1", name: "name", amount: 10, createdAt: Date())
        _ = repository.add(expense: expense)
        
        let result = repository.delete(expense: expense)
        
        expect(result).to(beTrue())
      }
    }
    
    context("when update expense") {
      it("when it doesn't exist should return false") {
        let expense = Expense(expenseId: "1", name: "name", amount: 10, createdAt: Date())
        
        let result = repository.update(expense: expense)
        
        expect(result).to(beFalse())
      }
      it("when is updated should return true") {
        let expense = Expense(expenseId: "1", name: "name", amount: 10, createdAt: Date())
        _ = repository.add(expense: expense)
        
        let newExpense = Expense(expenseId: expense.expenseId, name: "other", amount: expense.amount, createdAt: expense.createdAt)
        
        let result = repository.update(expense: newExpense)
        
        expect(result).to(beTrue())
        
        let expenseResult = repository.find(expenseId: expense.expenseId)
        
        expect(expenseResult).toNot(beNil())
        expect(expenseResult?.name).to(equal(newExpense.name))
      }
    }
  }
}
