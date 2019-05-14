import UIKit

class TextFormFieldView: FormFieldView {

  @IBOutlet private weak var titleLabel: UILabel!
  @IBOutlet private weak var textField: UITextField!

  override func awakeFromNib() {
    super.awakeFromNib()

    self.backgroundColor = .clear

    self.textField.delegate = self

    self.titleLabel.font = UIFont.systemFont(ofSize: 14.0)
    self.titleLabel.textColor = .darkGray
    self.textField.font = UIFont.systemFont(ofSize: 18.0)
    self.textField.textColor = .black
    self.textField.tintColor = .black
  }

  override func becomeFirstResponder() -> Bool {
    return self.textField.becomeFirstResponder()
  }

  override func resignFirstResponder() -> Bool {
    return self.textField.resignFirstResponder()
  }
}

extension TextFormFieldView: FormFieldProtocol {

  var title: String? {
    get { return self.titleLabel.text }
    set { self.titleLabel.text = newValue }
  }

  var value: Any? {
    get { return self.textField.text }
    set { self.textField.text = newValue as? String }
  }

  func setReturnKeyType(_ type: UIReturnKeyType) {
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
      self.field?.value = text
      self.formDelegate?.fieldDidChange(self.field)
    }
    return true
  }

  func textFieldDidBeginEditing(_ textField: UITextField) {
    textField.textColor = .black
  }

  func textFieldDidEndEditing(_ textField: UITextField) {
    textField.textColor = .darkGray
    self.formDelegate?.fieldDidEndEditing(self.field)
  }
}
