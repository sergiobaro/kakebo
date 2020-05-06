import Foundation

protocol AddExpenseView: class {
  
  func display(title: String)
  func display(fields: [FormFieldModel])
  func displaySave(enabled: Bool)

  func currentFields() -> [FormFieldModel]
  
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
  private let expense: Expense?
  
  private let timeFormatter = TimeFormatter()

  private var isEditing: Bool { self.expense != nil }

  private var selectedCategories = [ExpenseCategory]()
  
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
    self.expense = expense
    self.selectedCategories = expense?.categories ?? []
  }
  
  // MARK: - Private

  private func currentExpense() -> Expense? {
    guard let fields = self.view?.currentFields() else {
      return nil
    }

    return self.expense(with: fields)
  }

  private func expense(with fields: [FormFieldModel]) -> Expense? {
    let name = fields.first(where: { $0.identifier == ExpenseFormIdentifier.name.rawValue })?.value as? String
    let amount = fields.first(where: { $0.identifier == ExpenseFormIdentifier.amount.rawValue })?.value as? Int
    let date = fields.first(where: { $0.identifier == ExpenseFormIdentifier.date.rawValue })?.value as? Date
    let time = fields.first(where: { $0.identifier == ExpenseFormIdentifier.time.rawValue })?.value as? String

    let createdAt = self.createdAt(date: date, time: time)

    return self.expense(name: name, amount: amount, createdAt: createdAt)
  }

  private func createdAt(date: Date?, time: String?) -> Date? {
    guard
      let date = date,
      let time = time
    else {
        return nil
    }

    var dateComponents = Calendar.current.dateComponents([.day, .month, .year], from: date)
    guard let timeComponents = self.timeComponents(from: time) else {
      return nil
    }

    dateComponents.hour = timeComponents.hour
    dateComponents.minute = timeComponents.minute

    return Calendar.current.date(from: dateComponents)
  }
  
  private func timeComponents(from time: String) -> DateComponents? {
    let components = time.split(separator: ":")
    
    guard
      let hour = Int(components[0]), hour < 60,
      let minute = Int(components[1]), minute < 60
    else {
      return nil
    }
    
    return DateComponents(hour: hour, minute: minute)
  }

  private func expense(name: String?, amount: Int?, createdAt: Date?) -> Expense? {
    guard
      let name = name?.trimmingCharacters(in: .whitespaces),
      !name.isEmpty,
      let amount = amount,
      let createdAt = createdAt
    else {
        return nil
    }

    return Expense(
      expenseId: self.expense?.expenseId ?? UUID().uuidString,
      name: name,
      amount: amount,
      createdAt: createdAt,
      categories: []
    )
  }

  private func fields(from expense: Expense?) -> [FormFieldModel] {
    let nameField = FormFieldModel(
      type: .text,
      identifier: ExpenseFormIdentifier.name.rawValue,
      title: localize("Name"),
      validators: [NotEmptyValidator()],
      value: expense?.name
    )
    let amountField = FormFieldModel(
      type: .amount,
      identifier: ExpenseFormIdentifier.amount.rawValue,
      title: localize("Amount"),
      validators: [NotNilValidator()],
      value: expense?.amount ?? 0
    )
    let dateField = FormFieldModel(
      type: .date,
      identifier: ExpenseFormIdentifier.date.rawValue,
      title: localize("Date"),
      validators: [NotNilValidator()],
      value: expense?.createdAt ?? Date()
    )
    let timeField = FormFieldModel(
      type: .time,
      identifier: ExpenseFormIdentifier.time.rawValue,
      title: localize("Time"),
      validators: [NotNilValidator(), TimeValidator()],
      value: self.timeFormatter.string(date: expense?.createdAt ?? Date())
    )
    let categoryField = FormFieldModel(
      type: .options,
      identifier: ExpenseFormIdentifier.categories.rawValue,
      title: localize("Category"),
      validators: [],
      value: selectedCategories.map({ $0.name }).joined(separator: ", ")
    )

    return [nameField, amountField, dateField, timeField, categoryField]
  }
}

extension AddExpensePresenter {
  
  func viewIsReady() {
    let title = self.isEditing ? "Edit" : "Add"
    self.view?.display(title: title)

    let fields = self.fields(from: expense)
    self.view?.display(fields: fields)
    
    self.view?.displaySave(enabled: false)
  }

  func userChanged(fields: [FormFieldModel]) {
    let isValid = (self.expense(with: fields) != nil)
    self.view?.displaySave(enabled: isValid)
  }
  
  func userTapDone() {
    guard var expense = self.currentExpense() else {
      return
    }

    expense.categories = selectedCategories

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
      selectedCategories: expense?.categories ?? [],
      delegate: self
    )
  }
}

extension AddExpensePresenter: CategorySelectorDelegate {

  func didSelectCategories(_ categories: [ExpenseCategory]) {
    guard categories != selectedCategories else {
      return
    }

    self.selectedCategories = categories
    let fields = self.fields(from: expense)
    self.view?.display(fields: fields)
    self.view?.displaySave(enabled: true)
  }
}
