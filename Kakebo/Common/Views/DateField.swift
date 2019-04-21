import UIKit

protocol DateFieldDelegate: class {
  
  func dateField(_ dateField: DateField, didChangeValue value: Date?)
  func dateField(_ dateField: DateField, didFinishEditingWithValue value: Date?)
  
}

class DateField: UIView {
  
  var value: Date? {
    get {
      if self.text.isEmpty {
        return Date()
      }
      return self.dateFormatter.date(string: self.text)
    }
    set {
      let value = self.dateFormatter.string(date: newValue ?? Date())
      self.updateValue(value)
    }
  }
  
  weak var delegate: DateFieldDelegate?
  
  private weak var label: UILabel!
  private weak var placeholderLabel: UILabel!
  
  private let dateFormatter = ExpenseDateFormatter()
  private var text = ""

  override func awakeFromNib() {
    super.awakeFromNib()
    
    self.backgroundColor = .clear
    
    self.setupBorder()
    self.setupLabels()
    self.setupTap()
  }
  
  // MARK: - Setup
  
  private func setupBorder() {
    self.layer.borderColor = UIColor.lightGray.cgColor
    self.layer.borderWidth = 1.0
    self.layer.cornerRadius = 2.0
  }
  
  private func setupLabels() {
    self.label = self.makeLabel()
    
    self.placeholderLabel = self.makeLabel()
    self.placeholderLabel.textColor = .lightGray
    self.placeholderLabel.text = self.dateFormatter.dateFormat
  }
  
  private func makeLabel() -> UILabel {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .center
    label.font = UIFont.systemFont(ofSize: 16.0)
    self.addSubview(label)
    
    NSLayoutConstraint.activate([
      label.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
      label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
      label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
      label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5)
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
    self.layer.borderColor = (self.value != nil ? UIColor.lightGray : UIColor.red).cgColor
    
    return super.resignFirstResponder()
  }
  
  // MARK: - Private
  
  private func updateValue(_ string: String) {
    self.text = self.dateFormatter.trim(string: string)
    self.label.text = self.dateFormatter.string(string: self.text)
    
    self.delegate?.dateField(self, didChangeValue: self.value)
    
    self.placeholderLabel.isHidden = self.hasText
  }
}

extension DateField: UIKeyInput {
  
  var hasText: Bool {
    return !self.text.isEmpty
  }
  
  func insertText(_ text: String) {
    guard text != "\n" else {
      self.delegate?.dateField(self, didFinishEditingWithValue: self.value)
      return
    }
    
    let newValue = self.text + text
    self.updateValue(newValue)
  }
  
  func deleteBackward() {
    guard !self.text.isEmpty else {
      return
    }
    
    let newValue = self.text.dropLast().asString()
    self.updateValue(newValue)
  }
}
