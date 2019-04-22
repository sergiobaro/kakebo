import Foundation

class DefaultExpensesPresenter {
  
  private typealias ExpenseSections = Sections<String, Expense>
  
  private let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .short
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
      date: self.map(createdAt: expense.createdAt)
    )
  }
  
  private func map(createdAt date: Date) -> String {
    return self.dateFormatter.string(from: date)
  }
  
  private func sections(from expenses: [Expense]) -> ExpenseSections {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .none
    
    return .init(elements: expenses, groupBy: { expense in
      return dateFormatter.string(from: expense.createdAt)
    })
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
    return self.expenses.section(at: section)
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
