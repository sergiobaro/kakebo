import Foundation

class DateFormFieldPresenter {

  private weak var view: InputFormFieldViewProtocol?
  private weak var formDelegate: FormFieldDelegate?
  private let formatter: GeneralDateFormatter
  private var field: FormFieldModel
  private var text = ""

  init(
    view: InputFormFieldViewProtocol,
    formDelegate: FormFieldDelegate,
    field: FormFieldModel,
    formatter: GeneralDateFormatter
  ) {
    self.view = view
    self.formDelegate = formDelegate
    self.field = field
    self.formatter = formatter

    self.updateValue(date: field.value as? Date)
  }

  private func updateValue(date: Date?) {
    let value = self.formatter.string(date: date ?? Date())
    self.updateValue(value)
  }

  private func updateValue(_ string: String) {
    self.text = self.formatter.trim(string: string)

    let formattedText = self.formatter.string(string: self.text)
    self.view?.updateText(formattedText)

    self.field.value = self.formatter.date(string: self.text)
    self.formDelegate?.fieldDidChange(self.field)
  }
}

extension DateFormFieldPresenter: InputFormFieldPresenter {

  var hasText: Bool {
    return !self.text.isEmpty
  }

  func userInsertText(_ text: String) {
    guard text != "\n" else {
      self.formDelegate?.fieldDidEndEditing(self.field)
      return
    }

    let newValue = self.text + text
    self.updateValue(newValue)
  }

  func userDeleteBackward() {
    guard self.hasText else {
      return
    }

    let newValue = String(self.text.dropLast())
    self.updateValue(newValue)
  }
}
