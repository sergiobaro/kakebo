import UIKit

class TextFormFieldView: FormFieldView {

  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var textField: UITextField!

  override func awakeFromNib() {
    super.awakeFromNib()

    self.textField.delegate = self
    self.textField.returnKeyType = .next

    self.titleLabel.font = UIFont.systemFont(ofSize: 14.0)
    self.titleLabel.textColor = .darkGray
    self.textField.font = UIFont.systemFont(ofSize: 16.0)
    self.textField.textColor = .black
  }

  override func becomeFirstResponder() -> Bool {
    return self.textField.becomeFirstResponder()
  }

  override func resignFirstResponder() -> Bool {
    return self.textField.resignFirstResponder()
  }

  override func setReturnKeyType(_ type: UIReturnKeyType) {
    self.textField.returnKeyType = type
  }
}

extension TextFormFieldView: UITextFieldDelegate {

  // swiftlint:disable:next line_length
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    if string == "\n" {
      defer { self.formDelegate?.fieldDidEndEditing(self.field) }
      return false
    }
    
    if let text = textField.text?.replacing(in: range, with: string) {
      self.field?.type = .text(text)
      self.formDelegate?.fieldDidChange(self.field)
    }
    return true
  }

  func textFieldDidEndEditing(_ textField: UITextField) {
    self.formDelegate?.fieldDidEndEditing(self.field)
  }
}
