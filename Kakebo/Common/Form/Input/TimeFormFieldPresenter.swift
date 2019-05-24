import UIKit

class TimeFormFieldPresenter {

  weak var formDelegate: FormFieldDelegate?
  var field: FormFieldModel!

  private weak var view: InputFormFieldViewProtocol?

  private let timeFormatter = GeneralDateFormatter(fields: ["HH", "mm"], separator: " : ")
  private var text = ""

  init(view: InputFormFieldViewProtocol) {
    self.view = view
  }

  private func updateValue(_ string: String) {
    self.text = self.timeFormatter.trim(string: string)

    let value = self.timeFormatter.string(string: self.text)
    self.view?.updateValue(value)

    self.field.value = self.value
    self.formDelegate?.fieldDidChange(self.field)
  }
}

extension TimeFormFieldPresenter: InputFormFieldPresenter {

  var value: Any? {
    get {
      if self.text.isEmpty {
        return Date()
      }
      return self.timeFormatter.date(string: self.text)
    }
    set {
      let value = self.timeFormatter.string(date: (newValue as? Date) ?? Date())
      self.updateValue(value)
    }
  }

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
    guard !self.text.isEmpty else {
      return
    }

    let newValue = String(self.text.dropLast())
    self.updateValue(newValue)
  }
}