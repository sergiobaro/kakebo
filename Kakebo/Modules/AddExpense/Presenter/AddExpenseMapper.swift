import Foundation

struct AddExpenseMapper {

  private let timeFormatter = TimeFormatter()

  func temporalExpense(with expense: Expense?) -> TemporalExpense {
    TemporalExpense(
      expenseId: expense?.expenseId ?? UUID().uuidString,
      name: expense?.name ?? "",
      amount: expense?.amount ?? 0,
      createdAt: expense?.createdAt ?? Date(),
      categories: expense?.categories ?? []
    )
  }

  func expense(from tempExpense: TemporalExpense) -> Expense {
    Expense(
      expenseId: tempExpense.expenseId,
      name: tempExpense.name,
      amount: tempExpense.amount,
      createdAt: tempExpense.createdAt,
      categories: tempExpense.categories
    )
  }

  func fields(from expense: TemporalExpense) -> [FormFieldModel] {
    let nameField = FormFieldModel(
      type: .text,
      identifier: ExpenseFormIdentifier.name.rawValue,
      title: localize("Name"),
      validators: [NotEmptyValidator()],
      value: expense.name
    )
    let amountField = FormFieldModel(
      type: .amount,
      identifier: ExpenseFormIdentifier.amount.rawValue,
      title: localize("Amount"),
      validators: [NotNilValidator()],
      value: expense.amount
    )
    let dateField = FormFieldModel(
      type: .date,
      identifier: ExpenseFormIdentifier.date.rawValue,
      title: localize("Date"),
      validators: [NotNilValidator()],
      value: expense.createdAt
    )
    let timeField = FormFieldModel(
      type: .time,
      identifier: ExpenseFormIdentifier.time.rawValue,
      title: localize("Time"),
      validators: [NotNilValidator(), TimeValidator()],
      value: timeFormatter.string(date: expense.createdAt)
    )
    let categoryField = FormFieldModel(
      type: .options,
      identifier: ExpenseFormIdentifier.categories.rawValue,
      title: localize("Category"),
      validators: [],
      value: expense.categories.map({ $0.name }).joined(separator: ", ")
    )

    return [nameField, amountField, dateField, timeField, categoryField]
  }

  func updateExpense(_ tempExpense: TemporalExpense, with fields: [FormFieldModel]) -> TemporalExpense {
    var tempExpense = tempExpense
    let fieldsCollection = ExpenseFieldsCollection(fields: fields)

    if let name = fieldsCollection.name {
      tempExpense.name = name
    }
    if let amount = fieldsCollection.amount {
      tempExpense.amount = amount
    }
    if let date = fieldsCollection.date,
      let time = fieldsCollection.time,
      let createdAt = createdAt(date: date, time: time) {

      tempExpense.createdAt = createdAt
    }

    return tempExpense
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
}

private struct ExpenseFieldsCollection {

  let fields: [FormFieldModel]

  var name: String? {
    fields.first(where: { $0.identifier == ExpenseFormIdentifier.name.rawValue })?.value as? String
  }
  var amount: Int? {
    fields.first(where: { $0.identifier == ExpenseFormIdentifier.amount.rawValue })?.value as? Int
  }
  var date: Date? {
    fields.first(where: { $0.identifier == ExpenseFormIdentifier.date.rawValue })?.value as? Date
  }
  var time: String? {
    fields.first(where: { $0.identifier == ExpenseFormIdentifier.time.rawValue })?.value as? String
  }
}
