import Foundation

protocol AmountFormFieldViewProtocol: class {

  func updateValue(_ value: String?)

}

class AmountFormFieldDefaultPresenter {

  weak var formDelegate: FormFieldDelegate?
  var field: FormFieldModel!

  private weak var view: AmountFormFieldViewProtocol?
  private let formatter = AmountFormatter()
  private var text: String?

  init(view: AmountFormFieldViewProtocol) {
    self.view = view
  }

  // MARK: - Private

  private func updateValue(string: String?) {
    self.text = string

    let formatted = string.flatMap({ self.formatter.string(string: $0) })
    self.view?.updateValue(formatted)

    let intValue = string.flatMap(Int.init)
    self.field.value = intValue
    self.formDelegate?.fieldDidChange(self.field)
  }

  private func updateValue(integer: Int?) {
    if let value = integer {
      self.updateValue(string: String(value))
    }
  }
}

extension AmountFormFieldDefaultPresenter: AmountFormFieldPresenter {

  var value: Int? {
    get { return self.text.flatMap(Int.init) }
    set { self.updateValue(integer: newValue) }
  }

  var hasText: Bool {
    return !(text?.isEmpty ?? true)
  }

  func userInsertText(_ text: String) {
    guard text != "\n" else {
      self.formDelegate?.fieldDidEndEditing(self.field)
      return
    }
    guard Int(text) != nil else {
      return
    }

    let newValue = self.text.flatMap({ $0 + text }) ?? text
    self.updateValue(string: newValue)
  }

  func userDeleteBackward() {
    guard
      let text = self.text,
      !text.isEmpty else {
        return
    }

    let newValue = String(text.dropLast())
    self.updateValue(string: newValue)
  }
}
