import Foundation

struct ExpenseDay {

  let amount: Int
  let date: Date

  init(expenses: [Expense]) {
    self.amount = expenses.reduce(0) { $0 + $1.amount }
    self.date = expenses[0].createdAt
  }
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

  private let repository: ExpensesRepository

  init(repository: ExpensesRepository) {
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
    return ExpenseSections(elements: expenses, groupBy: { self.flat(date: $0.date) })
  }

  private func flat(date: Date) -> Date {
    let components = Calendar.current.dateComponents([.month, .year], from: date)
    return Calendar.current.date(from: components) ?? date
  }
}

extension MonthExpenseListPresenter: ExpenseListPresenter {

  func viewAppear() {
    let expensesByDay = self.repository.allExpenses()
      .group(by: { self.flat(date: $0.createdAt) })
      .values
      .map({ ExpenseDay(expenses: $0) })

    self.expenses = self.sections(from: expensesByDay)
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
    return false
  }

  func canDelete(at indexPath: IndexPath) -> Bool {
    return false
  }

  func deleteExpense(at indexPath: IndexPath) {
    // Nothing
  }

  func userTapAdd() {
    // Nothing
  }

  func userSelectExpense(indexPath: IndexPath) {
    // Nothing
  }
}
