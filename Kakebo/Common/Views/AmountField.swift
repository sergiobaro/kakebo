import UIKit

protocol AmountFieldDelegate: class {
  
  func amountField(_ amountField: AmountField, didChangeValue value: Int?)
  func amountField(_ amountField: AmountField, didFinishEditingWithValue value: Int?)
  
}

class AmountField: UIView {
  
  var value: Int? {
    get {
      return self.text.flatMap(Int.init)
    }
    set {
      self.updateValue(newValue.flatMap(String.init))
    }
  }
  
  weak var delegate: AmountFieldDelegate?
  
  private weak var label: UILabel!
  private weak var placeholderLabel: UILabel!
  
  private let formatter = AmountFormatter()
  private var text: String?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    self.backgroundColor = .clear
    
    self.setupBorder()
    self.setupLabel()
    self.setupTap()
    
    self.updateValue("0")
  }
  
  // MARK: - Setup
  
  private func setupBorder() {
    self.layer.borderColor = UIColor.lightGray.cgColor
    self.layer.borderWidth = 1.0
    self.layer.cornerRadius = 2.0
  }
  
  private func setupLabel() {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .right
    label.font = UIFont.systemFont(ofSize: 16.0)
    self.addSubview(label)
    
    NSLayoutConstraint.activate([
      label.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
      label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
      label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
      label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5)
    ])
    
    self.label = label
  }
  
  private func setupTap() {
    let tap = UITapGestureRecognizer(target: self, action: #selector(tapView))
    self.addGestureRecognizer(tap)
  }
  
  // MARK: - Actions
  
  @objc func tapView() {
    self.becomeFirstResponder()
  }
  
  // MARK: - UITextInputTraits
  
  var keyboardType: UIKeyboardType = .numberPad
  var autocorrectionType: UITextAutocorrectionType = .no

  // MARK: - UIResponder
  
  override var canBecomeFirstResponder: Bool {
    return true
  }
  
  @discardableResult
  override func becomeFirstResponder() -> Bool {
    self.layer.borderColor = UIColor.darkGray.cgColor
    
    return super.becomeFirstResponder()
  }
  
  @discardableResult
  override func resignFirstResponder() -> Bool {
    self.layer.borderColor = UIColor.lightGray.cgColor
    self.backgroundColor = .clear
    
    return super.resignFirstResponder()
  }
  
  // MARK: - Private
  
  private func updateValue(_ string: String?) {
    self.text = string
    self.label.text = string.flatMap({ self.formatter.formatString(from: $0) })
    self.valueChanged()
  }
  
  private func valueChanged() {
    let value = self.text
    
    let intValue = value.flatMap(Int.init)
    self.delegate?.amountField(self, didChangeValue: intValue)
  }
}

extension AmountField: UIKeyInput {
  
  var hasText: Bool {
    guard let text = self.text else {
      return false
    }
    
    return !text.isEmpty
  }
  
  func insertText(_ text: String) {
    guard text != "\n" else {
      self.delegate?.amountField(self, didFinishEditingWithValue: self.value)
      return
    }
    guard Int(text) != nil else {
      return
    }
    
    let newValue = self.text.flatMap({ $0 + text }) ?? text
    self.updateValue(newValue)
  }
  
  func deleteBackward() {
    guard
      let text = self.text,
      !text.isEmpty else {
        return
    }
    
    let newValue = String(text.dropLast())
    self.updateValue(newValue)
  }
}
