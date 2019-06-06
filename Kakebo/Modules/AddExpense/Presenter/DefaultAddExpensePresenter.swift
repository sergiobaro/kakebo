import Foundation

protocol AddExpenseView: class {
  
  func display(title: String)
  func display(fields: [FormFieldModel])
  func displaySave(enabled: Bool)

  func currentFields() -> [FormFieldModel]
  
}

class DefaultAddExpensePresenter {
  
  private weak var view: AddExpenseView?
  private let router: AddExpenseRouter
  private let repository: ExpensesRepository
  private let expense: Expense?

  private var isEditing: Bool {
    return self.expense != nil
  }
  
  init(view: AddExpenseView, router: AddExpenseRouter, repository: ExpensesRepository, expense: Expense?) {
    self.view = view
    self.router = router
    self.repository = repository
    self.expense = expense
  }
  
  // MARK: - Private

  private func currentExpense() -> Expense? {
    guard let fields = self.view?.currentFields() else {
      return nil
    }

    return self.expense(with: fields)
  }

  private func expense(with fields: [FormFieldModel]) -> Expense? {
    let name = fields.first(where: { $0.identifier == "name" })?.value as? String
    let amount = fields.first(where: { $0.identifier == "amount" })?.value as? Int
    let date = fields.first(where: { $0.identifier == "date" })?.value as? Date
    let time = fields.first(where: { $0.identifier == "time" })?.value as? Date

    let createdAt = self.createdAt(date: date, time: time)

    return self.expense(name: name, amount: amount, createdAt: createdAt)
  }

  private func createdAt(date: Date?, time: Date?) -> Date? {
    guard
      let date = date,
      let time = time
      else {
        return nil
    }

    var dateComponents = Calendar.current.dateComponents([.day, .month, .year], from: date)
    let timeComponents = Calendar.current.dateComponents([.hour, .minute], from: time)

    dateComponents.hour = timeComponents.hour
    dateComponents.minute = timeComponents.minute

    return Calendar.current.date(from: dateComponents)
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
      createdAt: createdAt
    )
  }

  private func fields(from expense: Expense?) -> [FormFieldModel] {
    let nameField = FormFieldModel(
      type: .text,
      identifier: "name",
      title: localize("Name"),
      validators: [NotEmptyValidator()],
      value: expense?.name
    )
    let amountField = FormFieldModel(
      type: .amount,
      identifier: "amount",
      title: localize("Amount"),
      validators: [NotNilValidator()],
      value: expense?.amount ?? 0
    )
    let dateField = FormFieldModel(
      type: .date,
      identifier: "date",
      title: localize("Date"),
      validators: [NotNilValidator()],
      value: expense?.createdAt ?? Date()
    )
    let timeField = FormFieldModel(
      type: .time,
      identifier: "time",
      title: localize("Time"),
      validators: [NotNilValidator()],
      value: expense?.createdAt ?? Date()
    )

    return [nameField, amountField, dateField, timeField]
  }
}

extension DefaultAddExpensePresenter: AddExpensePresenter {
  
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
    guard let expense = self.currentExpense() else {
      return
    }
    
    if self.isEditing && self.repository.update(expense: expense) {
      self.router.navigateBack()
    } else if self.repository.add(expense: expense) {
      self.router.navigateBack()
    }
  }
  
  func userTapCancel() {
    self.router.navigateBack()
  }
}
