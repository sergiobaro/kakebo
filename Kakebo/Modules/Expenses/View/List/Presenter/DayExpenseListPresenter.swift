import Foundation

class DayExpenseListPresenter {

  private typealias ExpenseSections = Sections<Date, Expense>
  
  private let rowDateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm"
    return dateFormatter
  }()
  
  private let sectionDateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .none
    return dateFormatter
  }()
  
  private let amountFormatter = AmountFormatter()
  private var expenses = ExpenseSections()

  private weak var view: ExpenseListViewProtocol?
  private let router: ExpenseListRouter
  private let repository: ExpensesRepository
  
  init(view: ExpenseListViewProtocol, router: ExpenseListRouter, repository: ExpensesRepository) {
    self.view = view
    self.router = router
    self.repository = repository
  }
  
  // MARK: - Private
  
  private func map(expense: Expense) -> ExpenseListViewModel {
    return ExpenseListViewModel(
      name: expense.name,
      amount: self.amountFormatter.string(integer: expense.amount),
      date: self.rowDateFormatter.string(from: expense.createdAt)
    )
  }
  
  private func sections(from expenses: [Expense]) -> ExpenseSections {
    return ExpenseSections(elements: expenses, groupBy: { self.flat(date: $0.createdAt) })
  }
  
  private func flat(date: Date) -> Date {
    let components = Calendar.current.dateComponents([.day, .month, .year], from: date)
    return Calendar.current.date(from: components) ?? date
  }
}

extension DayExpenseListPresenter: ExpenseListPresenter {
  
  func viewAppear() {
    let expenses = self.repository.allExpenses()
    
    self.expenses = self.sections(from: expenses)
  }
  
  func numberOfSections() -> Int {
    return self.expenses.numberOfSections
  }
  
  func expenseSection(for section: Int) -> ExpenseListSectionViewModel? {
    guard let date = self.expenses.section(at: section) else {
      return nil
    }
    
    let dateString = self.sectionDateFormatter.string(from: date)
    let totalAmount = self.expenses.elements(section: section)
      .map({ $0.amount })
      .reduce(0) { return $0 + $1 }
    let totalString = self.amountFormatter.string(integer: totalAmount)
    
    return ExpenseListSectionViewModel(
      title: dateString,
      totalAmount: totalString
    )
  }
  
  func numberOfExpenses(section: Int) -> Int {
    return self.expenses.numberOfElements(section: section)
  }
  
  func expense(at indexPath: IndexPath) -> ExpenseListViewModel? {
    return self.expenses.element(at: indexPath).map(self.map(expense:))
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
  }

  func userTapAdd() {
    self.router.navigateToAddExpense()
  }
  
  func userSelectExpense(indexPath: IndexPath) {
    guard let expense = self.expenses.element(at: indexPath) else {
      return
    }
    self.router.navigateToExpenseDetail(expense: expense)
  }
}
