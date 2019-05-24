import Foundation

class AmountFormFieldPresenter {

  private weak var view: InputFormFieldViewProtocol?

  private let formatter = AmountFormatter()
  private var text: String?

  init(view: InputFormFieldViewProtocol) {
    self.view = view
  }

  // MARK: - Private

  private func updateValue(string: String?) {
    self.text = string

    let formattedText = string.flatMap({ self.formatter.string(string: $0) })
    self.view?.updateText(formattedText)

//    self.field.value = self.value
//    self.formDelegate?.fieldDidChange(self.field)
  }

  private func updateValue(integer: Int?) {
    if let value = integer {
      self.updateValue(string: String(value))
    }
  }
}

extension AmountFormFieldPresenter: InputFormFieldPresenter {

  var value: Any? {
    get { return self.text.flatMap(Int.init) }
    set { self.updateValue(integer: newValue as? Int) }
  }

  var hasText: Bool {
    return !(text?.isEmpty ?? true)
  }

  func userInsertText(_ text: String) {
    guard text != "\n" else {
//      self.formDelegate?.fieldDidEndEditing(self.field)
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
