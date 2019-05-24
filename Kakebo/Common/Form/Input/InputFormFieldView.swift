import UIKit

class InputFormFieldView: FormFieldView {

  @IBOutlet private weak var valueLabel: UILabel!

  override func awakeFromNib() {
    super.awakeFromNib()

    self.backgroundColor = .clear

    self.valueLabel.font = FormStyle.textFont
    self.valueLabel.textColor = FormStyle.textColor
    self.valueLabel.text = nil
  }

  // MARK: - Actions

  @IBAction func tapView() {
    self.becomeFirstResponder()
    self.container?.fieldDidBecomeFirstResponder()
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
    return !(self.valueLabel.text?.isEmpty ?? true)
  }

  func insertText(_ text: String) {
    if text == "\n" {
      self.resignFirstResponder()
      self.container?.fieldDidResignFirstResponder()
      return
    }

    self.valueLabel.text = self.valueLabel.text.map({ $0 + text }) ?? text
  }

  func deleteBackward() {
    self.valueLabel.text = self.valueLabel.text.map({ String($0.dropLast()) })
  }
}
