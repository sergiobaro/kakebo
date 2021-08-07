import Foundation

protocol DayExpenseListDelegate: AnyObject {
  func dayExpenseListDidSelectExpense(_ expense: Expense)
  func dayExpenseListDidDeleteExpense(_ expense: Expense)
}

class DayExpenseListPresenter {

  private typealias ExpenseSections = Sections<Date, Expense>
  
  private var expenses = ExpenseSections()
  private let mapper = ExpenseListMapper()

  private weak var view: ExpenseListViewProtocol?
  private weak var delegate: DayExpenseListDelegate?
  private let repository: ExpensesRepository
  
  init(view: ExpenseListViewProtocol, delegate: DayExpenseListDelegate, repository: ExpensesRepository) {
    self.view = view
    self.delegate = delegate
    self.repository = repository
  }
  
}

private extension DayExpenseListPresenter {
  
  private func sections(from expenses: [Expense]) -> ExpenseSections {
    return ExpenseSections(elements: expenses, groupBy: {
      $0.createdAt.keepingComponents([.day, .month, .year]) ?? $0.createdAt
    })
  }
  
  func reloadSections() {
    let expenses = self.repository.allExpenses()
    self.expenses = self.sections(from: expenses)
    self.view?.reloadData()
  }
}

extension DayExpenseListPresenter: ExpenseListPresenter {
  
  func viewIsReady() {
    self.reloadSections()
  }
  
  func reloadExpenses() {
    self.reloadSections()
  }
  
  func numberOfSections() -> Int {
    return self.expenses.numberOfSections
  }
  
  func expenseSection(for section: Int) -> ExpenseListSectionViewModel? {
    guard let date = self.expenses.section(at: section) else {
      return nil
    }
    
    let expenses = self.expenses.elements(section: section)
    return self.mapper.mapSection(date: date, expenses: expenses)
  }
  
  func numberOfExpenses(section: Int) -> Int {
    return self.expenses.numberOfElements(section: section)
  }
  
  func expense(at indexPath: IndexPath) -> ExpenseListViewModel? {
    return self.expenses.element(at: indexPath)
      .map { self.mapper.map(expense: $0) }
  }

  func canSelect(at indexPath: IndexPath) -> Bool {
    return true
  }

  func canDelete(at indexPath: IndexPath) -> Bool {
    return true
  }
  
  func deleteExpense(at indexPath: IndexPath) {
    guard let expense = self.expenses.element(at: indexPath) else {
      return
    }

    guard self.repository.delete(expense: expense) else {
      return
    }

    let numberOfExpensesInSection = self.expenses.numberOfElements(section: indexPath.section)
    self.expenses.deleteElement(at: indexPath)

    if numberOfExpensesInSection == 1 {
      self.view?.delete(section: indexPath.section)
    } else {
      self.view?.deleteRow(at: indexPath)
    }
    
    self.delegate?.dayExpenseListDidDeleteExpense(expense)
  }
  
  func userSelectExpense(indexPath: IndexPath) {
    guard let expense = self.expenses.element(at: indexPath) else {
      return
    }
    
    self.delegate?.dayExpenseListDidSelectExpense(expense)
  }
}
