import UIKit

class TextFormFieldView: FormFieldView {

  @IBOutlet private weak var textField: UITextField!

  override func awakeFromNib() {
    super.awakeFromNib()

    self.backgroundColor = .clear

    self.textField.delegate = self

    self.textField.font = FormStyle.textFont
    self.textField.textColor = FormStyle.textColor
    self.textField.tintColor = FormStyle.textColor
  }

  // MARK: - FormFieldView

  override func focus() {
    self.textField.becomeFirstResponder()
  }

  override func blur() {
    self.textField.resignFirstResponder()
  }

  override func setReturnKeyType(_ type: UIReturnKeyType) {
    self.textField.returnKeyType = type
  }
}

extension TextFormFieldView: UITextFieldDelegate {

  // swiftlint:disable:next line_length
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    if string == "\n" {
      defer { self.container?.fieldDidResignFirstResponder() }
      return false
    }

//    if let text = textField.text?.replacing(in: range, with: string) {
//      self.field?.value = text
//      self.formDelegate?.fieldDidChange(self.field)
//    }
    return true
  }

  func textFieldDidBeginEditing(_ textField: UITextField) {
    self.container?.fieldDidBecomeFirstResponder()
  }

  func textFieldDidEndEditing(_ textField: UITextField) {
    self.container?.fieldDidResignFirstResponder()
  }
}
