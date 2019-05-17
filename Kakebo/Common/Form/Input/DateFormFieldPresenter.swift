import Foundation

class DateFormFieldPresenter {
  
  weak var formDelegate: FormFieldDelegate?
  var field: FormFieldModel!

  private weak var view: InputFormFieldViewProtocol?
  
  private let dateFormatter = GeneralDateFormatter(fields: ["dd", "MM", "yyyy"], separator: " / ")
  private var text = ""

  init(view: InputFormFieldViewProtocol) {
    self.view = view
  }

  private func updateValue(_ string: String) {
    self.text = self.dateFormatter.trim(string: string)

    let value = self.dateFormatter.string(string: self.text)
    self.view?.updateValue(value)
    
    self.field.value = self.value
    self.formDelegate?.fieldDidChange(self.field)
  }
}

extension DateFormFieldPresenter: InputFormFieldPresenter {

  var value: Any? {
    get {
      if self.text.isEmpty {
        return Date()
      }
      return self.dateFormatter.date(string: self.text)
    }
    set {
      let value = self.dateFormatter.string(date: (newValue as? Date) ?? Date())
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
