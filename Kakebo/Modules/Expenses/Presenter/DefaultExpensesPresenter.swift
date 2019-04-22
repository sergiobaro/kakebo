import Foundation

class DefaultExpensesPresenter {
  
  private typealias ExpenseSections = Sections<Date, Expense>
  
  private let rowDateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .none
    dateFormatter.timeStyle = .short
    return dateFormatter
  }()
  
  private let sectionDateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .none
    return dateFormatter
  }()
  
  private let amountFormatter = AmountFormatter()

  private let router: ExpensesRouter
  private let repository: ExpensesRepository
  
  private var expenses = ExpenseSections()
  
  init(router: ExpensesRouter, repository: ExpensesRepository) {
    self.router = router
    self.repository = repository
  }
  
  // MARK: - Private
  
  private func map(expense: Expense) -> ExpenseViewModel {
    return ExpenseViewModel(
      name: expense.name,
      amount: self.amountFormatter.string(integer: expense.amount),
      date: self.rowDateFormatter.string(from: expense.createdAt)
    )
  }
  
  private func sections(from expenses: [Expense]) -> ExpenseSections {
    return .init(elements: expenses, groupBy: { self.flat(date: $0.createdAt) })
  }
  
  private func flat(date: Date) -> Date {
    let components = Calendar.current.dateComponents([.day, .month, .year], from: date)
    return Calendar.current.date(from: components) ?? date
  }
}

extension DefaultExpensesPresenter: ExpensesPresenter {
  
  func viewReady() {
    // nop
  }
  
  func viewAppear() {
    let expenses = self.repository.allExpenses()
    
    self.expenses = self.sections(from: expenses)
  }
  
  func numberOfSections() -> Int {
    return self.expenses.numberOfSections
  }
  
  func sectionTitle(for section: Int) -> String? {
    guard let date = self.expenses.section(at: section) else {
      return nil
    }
    
    return self.sectionDateFormatter.string(from: date)
  }
  
  func numberOfExpenses(section: Int) -> Int {
    return self.expenses.numberOfElements(section: section)
  }
  
  func expense(at indexPath: IndexPath) -> ExpenseViewModel? {
    return self.expenses.element(at: indexPath).map(self.map(expense:))
  }
  
  func deleteExpense(at indexPath: IndexPath) -> Bool {
    guard let expense = self.expenses.element(at: indexPath) else {
      return false
    }
    guard self.repository.delete(expense: expense) else {
      return false
    }

    self.expenses.deleteElement(at: indexPath)

    return true
  }

  func userTapAdd() {
    self.router.navigateToAddExpense()
  }
}
