import Foundation

class AmountFormFieldPresenter {

  private weak var view: InputFormFieldViewProtocol?
  private weak var formDelegate: FormFieldDelegate?
  private var field: FormFieldModel
  private let formatter = AmountFormatter()
  private var text = ""

  required init(view: InputFormFieldViewProtocol, formDelegate: FormFieldDelegate, field: FormFieldModel) {
    self.view = view
    self.formDelegate = formDelegate
    self.field = field

    self.updateValue(integer: field.value as? Int)
  }

  // MARK: - Private

  private func updateValue(integer: Int?) {
    self.updateValue(string: integer.flatMap(String.init) ?? "")
  }

  private func updateValue(string: String) {
    self.text = string

    let formattedText = self.formatter.string(string: string)
    self.view?.updateText(formattedText)

    self.field.value = Int(string) ?? 0
    self.formDelegate?.fieldDidChange(self.field)
  }
}

extension AmountFormFieldPresenter: InputFormFieldPresenter {

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
    guard !self.text.isEmpty else {
      return
    }

    let newValue = String(text.dropLast())
    self.updateValue(string: newValue)
  }
}
