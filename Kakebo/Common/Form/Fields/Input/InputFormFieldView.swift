import UIKit

// sourcery: AutoMockable
protocol InputFormFieldViewProtocol: class {

  func updateText(_ text: String?)

}

protocol InputFormFieldPresenter {

  var hasText: Bool { get }

  func userInsertText(_ text: String)
  func userDeleteBackward()

}

class InputFormFieldView: FormFieldView {

  @IBOutlet private weak var valueLabel: UILabel!

  var presenter: InputFormFieldPresenter!

  override func awakeFromNib() {
    super.awakeFromNib()

    self.backgroundColor = .clear

    self.valueLabel.font = FormStyle.textFont
    self.valueLabel.textColor = FormStyle.textColor
    self.valueLabel.text = nil
  }

  // MARK: - UITextInputTraits

  var keyboardType: UIKeyboardType = .numberPad
  var autocorrectionType: UITextAutocorrectionType = .no
  var returnKeyType: UIReturnKeyType = .done

  // MARK: - UIResponder

  override var canBecomeFirstResponder: Bool {
    return true
  }

  // MARK: - FormFieldView

  override func focus() {
    self.becomeFirstResponder()
  }

  override func blur() {
    self.resignFirstResponder()
  }

  override func setReturnKeyType(_ type: UIReturnKeyType) {
    self.returnKeyType = type
  }
}

extension InputFormFieldView: UIKeyInput {

  var hasText: Bool {
    return self.presenter.hasText
  }

  func insertText(_ text: String) {
    self.presenter.userInsertText(text)
  }

  func deleteBackward() {
    self.presenter.userDeleteBackward()
  }
}

extension InputFormFieldView: InputFormFieldViewProtocol {

  func updateText(_ text: String?) {
    self.valueLabel.text = text
  }
}
