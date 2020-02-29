import Foundation

struct ExpenseDay: Comparable {

  let amount: Int
  let date: Date

  init(expenses: [Expense]) {
    self.amount = expenses.reduce(0) { $0 + $1.amount }
    self.date = expenses[0].createdAt
  }

  static func < (lhs: ExpenseDay, rhs: ExpenseDay) -> Bool {
    return lhs.date < rhs.date
  }

  static func == (lhs: ExpenseDay, rhs: ExpenseDay) -> Bool {
    return lhs.date == rhs.date
  }
}

protocol MonthExpenseListDelegate: class {
  func didSelectDay(_ expenseDay: ExpenseDay)
}

class MonthExpenseListPresenter {

  private typealias ExpenseSections = Sections<Date, ExpenseDay>

  private let rowDateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "d MMM"
    return dateFormatter
  }()

  private let sectionDateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMM yyyy"
    return dateFormatter
  }()

  private let amountFormatter = AmountFormatter()
  private var expenses = ExpenseSections()

  private weak var view: ExpenseListViewProtocol?
  private weak var delegate: MonthExpenseListDelegate?
  private let repository: ExpensesRepository

  init(view: ExpenseListViewProtocol, delegate: MonthExpenseListDelegate, repository: ExpensesRepository) {
    self.view = view
    self.delegate = delegate
    self.repository = repository
  }

  // MARK: - Private

  private func map(expense: ExpenseDay) -> ExpenseListViewModel {
    return ExpenseListViewModel(
      name: self.rowDateFormatter.string(from: expense.date),
      amount: self.amountFormatter.string(integer: expense.amount),
      date: ""
    )
  }

  private func sections(from expenses: [ExpenseDay]) -> ExpenseSections {
    return ExpenseSections(elements: expenses, groupBy: { self.flat(date: $0.date, components: [.month, .year]) })
  }

  private func flat(date: Date, components: Set<Calendar.Component>) -> Date {
    let components = Calendar.current.dateComponents(components, from: date)
    return Calendar.current.date(from: components) ?? date
  }
  
  private func reloadSections() {
    let expensesByDay = self.repository.allExpenses()
      .group(by: { self.flat(date: $0.createdAt, components: [.day, .month, .year]) })
      .values
      .map({ ExpenseDay(expenses: $0) })

    self.expenses = self.sections(from: expensesByDay)
    
    self.view?.reloadData()
  }
}

extension MonthExpenseListPresenter: ExpenseListPresenter {

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
    return false
  }

  func deleteExpense(at indexPath: IndexPath) {
    // Nothing
  }
  
  func userSelectExpense(indexPath: IndexPath) {
    guard let expense = self.expenses.element(at: indexPath) else {
      return
    }
    
    self.delegate?.didSelectDay(expense)
  }
}
