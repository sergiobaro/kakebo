import Foundation

protocol AddExpenseView: AnyObject {
  
  func display(title: String)
  func display(fields: [FormFieldModel])
  func displaySave(enabled: Bool)

  func currentFields() -> [FormFieldModel]
  
}

struct TemporalExpense {
  var expenseId: String
  var name: String
  var amount: Int
  var createdAt: Date
  var categories: [ExpenseCategory]
}

enum ExpenseFormIdentifier: String {
  case name
  case amount
  case date
  case time
  case categories
}

class AddExpensePresenter {
  
  private weak var view: AddExpenseView?
  private weak var delegate: AddExpenseDelegate?
  private let router: AddExpenseRouter
  private let repository: ExpensesRepository
  private let isEditing: Bool
  private let mapper = AddExpenseMapper()
  private var tempExpense: TemporalExpense
  
  init(
    view: AddExpenseView,
    delegate: AddExpenseDelegate,
    router: AddExpenseRouter,
    repository: ExpensesRepository,
    expense: Expense?
  ) {
    self.view = view
    self.delegate = delegate
    self.router = router
    self.repository = repository
    self.isEditing = (expense != nil)
    self.tempExpense = mapper.temporalExpense(with: expense)
  }
  
  // MARK: - Private

  private func isValid(expense: TemporalExpense) -> Bool {
    !expense.name.isEmpty
  }

  private func enableSaveIfValid() {
    let isValid = self.isValid(expense: tempExpense)
    self.view?.displaySave(enabled: isValid)
  }
}

extension AddExpensePresenter {
  
  func viewIsReady() {
    let title = isEditing ? localize("Edit") : localize("Add")
    self.view?.display(title: title)
    let fields = mapper.fields(from: tempExpense)
    self.view?.display(fields: fields)
    self.view?.displaySave(enabled: false)
  }

  func userChanged(fields: [FormFieldModel]) {
    tempExpense = mapper.updateExpense(tempExpense, with: fields)
    self.enableSaveIfValid()
  }
  
  func userTapDone() {
    guard self.isValid(expense: tempExpense) else {
      return
    }

    let expense = self.mapper.expense(from: self.tempExpense)

    if self.isEditing && self.repository.update(expense: expense) {
      self.delegate?.addExpenseDidSave(expense: expense)
      self.router.navigateBack()
    } else if self.repository.add(expense: expense) {
      self.delegate?.addExpenseDidSave(expense: expense)
      self.router.navigateBack()
    }
  }
  
  func userTapCancel() {
    self.router.navigateBack()
  }

  func userDidSelectField(_ field: FormFieldModel) {
    guard field.identifier == ExpenseFormIdentifier.categories.rawValue else { return }
    self.router.navigateToCategorySelector(
      selectedCategories: tempExpense.categories,
      delegate: self
    )
  }
}

extension AddExpensePresenter: CategorySelectorDelegate {

  func didSelectCategories(_ categories: [ExpenseCategory]) {
    guard categories != self.tempExpense.categories else {
      return
    }

    tempExpense.categories = categories
    let fields = mapper.fields(from: tempExpense)
    self.view?.display(fields: fields)
    self.enableSaveIfValid()
  }
}
