import Foundation

class TimeFormFieldPresenter {

  private weak var view: InputFormFieldViewProtocol?
  private weak var formDelegate: FormFieldDelegate?
  private let formatter: TimeFormatter
  private var field: FormFieldModel
  private var text = ""

  init(
    view: InputFormFieldViewProtocol,
    formDelegate: FormFieldDelegate,
    field: FormFieldModel,
    formatter: TimeFormatter
  ) {
    self.view = view
    self.formDelegate = formDelegate
    self.field = field
    self.formatter = formatter
    
    self.updateValue(string: field.value as? String ?? "")
  }

  private func updateValue(string: String) {
    self.text = self.formatter.trim(string: string)
    
    let value = self.formatter.string(string: self.text)
    self.view?.updateText(value)

    self.field.value = value
    self.formDelegate?.fieldDidChange(self.field)
  }
}

extension TimeFormFieldPresenter: InputFormFieldPresenter {
  
  var hasText: Bool {
    return !self.text.isEmpty
  }

  func userInsertText(_ text: String) {
    guard text != "\n" else {
      self.formDelegate?.fieldDidEndEditing(self.field)
      return
    }
    guard Int(text) != nil else {
      return
    }

    let newValue = self.text + text
    self.updateValue(string: newValue)
  }

  func userDeleteBackward() {
    guard self.hasText else {
      return
    }

    let newValue = String(self.text.dropLast())
    self.updateValue(string: newValue)
  }
}
