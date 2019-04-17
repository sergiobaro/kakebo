import UIKit

protocol AmountViewDelegate: class {
  
  func amountView(_ amountView: AmountView, didChangeValue value: Int?)
  
}

class AmountView: UIView {
  
  weak var delegate: AmountViewDelegate?
  
  private weak var label: UILabel!
  private weak var placeholderLabel: UILabel!
  
  var value: Int? {
    get {
      return self.label.text.flatMap(Int.init)
    }
    set {
      self.label.text = newValue.flatMap(String.init)
      self.valueChanged()
    }
  }
  
  var placeholder: String? {
    get {
      return self.placeholderLabel.text
    }
    set {
      self.placeholderLabel.text = newValue
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    self.backgroundColor = .clear
    
    self.setupBorder()
    self.setupLabel()
    self.setupPlaceholderLabel()
    self.setupTap()
  }
  
  // MARK: - Setup
  
  private func setupBorder() {
    self.layer.borderColor = UIColor.lightGray.cgColor
    self.layer.borderWidth = 1.0
    self.layer.cornerRadius = 2.0
  }
  
  private func setupLabel() {
    self.label = self.makeLabel()
  }
  
  private func setupPlaceholderLabel() {
    self.placeholderLabel = self.makeLabel()
    self.placeholderLabel.textColor = .lightGray
  }
  
  private func makeLabel() -> UILabel {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .center
    label.font = UIFont.systemFont(ofSize: 14.0)
    self.addSubview(label)
    
    NSLayoutConstraint.activate([
      label.topAnchor.constraint(equalTo: self.topAnchor),
      label.bottomAnchor.constraint(equalTo: self.bottomAnchor),
      label.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      label.trailingAnchor.constraint(equalTo: self.trailingAnchor)
    ])
    
    return label
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
    
    return super.resignFirstResponder()
  }
  
  // MARK: - Private
  
  private func updateValue(_ string: String?) {
    self.label.text = string
    self.valueChanged()
  }
  
  private func valueChanged() {
    let value = self.label.text
    let hasValue = value.flatMap({ !$0.isEmpty }) ?? false
    self.placeholderLabel.isHidden = hasValue
    
    let intValue = value.flatMap(Int.init)
    self.delegate?.amountView(self, didChangeValue: intValue)
  }
}

extension AmountView: UIKeyInput {
  
  var hasText: Bool {
    guard let text = self.label.text else {
      return false
    }
    
    return !text.isEmpty
  }
  
  func insertText(_ text: String) {
    guard Int(text) != nil else {
      return
    }
    
    let newValue = self.label.text.flatMap({ $0 + text }) ?? text
    self.updateValue(newValue)
  }
  
  func deleteBackward() {
    guard
      let text = self.label.text,
      !text.isEmpty else {
        return
    }
    
    let newValue = String(text.dropLast())
    self.updateValue(newValue)
  }
}
