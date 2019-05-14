import UIKit

class AmountFormFieldView: FormFieldView {
  
  @IBOutlet private weak var titleLabel: UILabel!
  @IBOutlet private weak var valueLabel: UILabel!
  
  private let formatter = AmountFormatter()
  private var text: String?

  override func awakeFromNib() {
    super.awakeFromNib()
    
    self.backgroundColor = .clear

    self.titleLabel.font = UIFont.systemFont(ofSize: 14.0)
    self.titleLabel.textColor = .darkGray
    self.valueLabel.font = UIFont.systemFont(ofSize: 18.0)
    self.valueLabel.textColor = .lightGray
  }

  // MARK: - Actions

  @IBAction func tapView() {
    self.becomeFirstResponder()
  }
  
  // MARK: - UITextInputTraits
  
  var keyboardType: UIKeyboardType = .numberPad
  var autocorrectionType: UITextAutocorrectionType = .no
  var returnKeyType: UIReturnKeyType = .done

  // MARK: - UIResponder
  
  override var canBecomeFirstResponder: Bool {
    return true
  }
  
  @discardableResult
  override func becomeFirstResponder() -> Bool {
    self.valueLabel.textColor = .black

    return super.becomeFirstResponder()
  }
  
  @discardableResult
  override func resignFirstResponder() -> Bool {
    self.valueLabel.textColor = .lightGray
    
    return super.resignFirstResponder()
  }
  
  // MARK: - Private
  
  private func updateValue(string: String?) {
    self.text = string
    self.valueLabel.text = string.flatMap({ self.formatter.string(string: $0) })
    
    let intValue = string.flatMap(Int.init)
    self.field.type = .amount(intValue)
    self.formDelegate?.fieldDidChange(self.field)
  }

  private func updateValue(integer: Int?) {
    guard let value = integer else {
      return
    }

    self.updateValue(string: String(value))
  }
}

extension AmountFormFieldView: FormFieldProtocol {

  var title: String? {
    get { return self.titleLabel.text }
    set { self.titleLabel.text = newValue }
  }

  var value: Any? {
    get { return self.text.flatMap(Int.init) }
    set { self.updateValue(integer: newValue as? Int) }
  }

  func setReturnKeyType(_ type: UIReturnKeyType) {
    self.returnKeyType = type
  }
}

extension AmountFormFieldView: UIKeyInput {
  
  var hasText: Bool {
    guard let text = self.text else {
      return false
    }

    return !text.isEmpty
  }
  
  func insertText(_ text: String) {
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
  
  func deleteBackward() {
    guard
      let text = self.text,
      !text.isEmpty else {
        return
    }
    
    let newValue = String(text.dropLast())
    self.updateValue(string: newValue)
  }
}
