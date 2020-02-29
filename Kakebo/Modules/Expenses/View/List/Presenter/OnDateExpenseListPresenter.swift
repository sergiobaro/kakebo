import Foundation

class OnDateExpenseListPresenter {
  
  private let titleDateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd MMM yyyy"
    return dateFormatter
  }()
  
  private weak var view: ExpenseListViewProtocol?
  private let date: Date
  private let repository: ExpensesRepository
  private let router: ExpenseListRouter
  private weak var delegate: ExpenseListDelegate?
  
  private var expenses = [Expense]()
  private let mapper = ExpenseListMapper()
  
  init(
    view: ExpenseListViewProtocol,
    date: Date,
    repository: ExpensesRepository,
    router: ExpenseListRouter,
    delegate: ExpenseListDelegate
  ) {
    self.view = view
    self.date = date
    self.repository = repository
    self.router = router
    self.delegate = delegate
  }
}

private extension OnDateExpenseListPresenter {
  
  func loadExpenses() {
    let startDate = self.date.keepingComponents([.day, .month, .year]) ?? self.date
    let endDate = startDate.addingComponents(.init(hour: 23, minute: 59, second: 59)) ?? self.date
    self.expenses = repository.findBetween(start: startDate, end: endDate)
    
    self.view?.reloadData()
  }
}

extension OnDateExpenseListPresenter: ExpenseListStandalonePresenter {
  
  func title() -> String? {
    return self.titleDateFormatter.string(from: self.date)
  }
  
  func userTapClose() {
    self.router.navigateBack()
  }
}

extension OnDateExpenseListPresenter: ExpenseListPresenter {
  
  func viewIsReady() {
    self.loadExpenses()
  }
  
  func reloadExpenses() {
    self.loadExpenses()
  }
  
  func numberOfSections() -> Int {
    return 1
  }
  
  func numberOfExpenses(section: Int) -> Int {
    return self.expenses.count
  }
  
  func expenseSection(for section: Int) -> ExpenseListSectionViewModel? {
    return self.mapper.mapSection(date: self.date, expenses: self.expenses)
  }
  
  func expense(at indexPath: IndexPath) -> ExpenseListViewModel? {
    self.expenses.element(at: indexPath.row)
      .map { self.mapper.map(expense: $0) }
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
  
  func userSelectExpense(indexPath: IndexPath) {
    // Nothing
  }
}
