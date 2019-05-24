import UIKit

protocol InputFormFieldPresenter {

  var formDelegate: FormFieldDelegate? { get set }
  var field: FormFieldModel! { get set }

  var value: Any? { get set }
  var hasText: Bool { get }

  func userInsertText(_ text: String)
  func userDeleteBackward()

}

// sourcery: AutoMockable
protocol InputFormFieldViewProtocol: class {

  func updateValue(_ value: String?)

}

class InputFormFieldView: FormFieldView {

  override var formDelegate: FormFieldDelegate? {
    get { return self.presenter.formDelegate }
    set { self.presenter.formDelegate = newValue }
  }

  override var field: FormFieldModel! {
    get { return self.presenter.field }
    set { self.presenter.field = newValue }
  }
  
  @IBOutlet private weak var titleLabel: UILabel!
  @IBOutlet private weak var valueLabel: UILabel!

  var presenter: InputFormFieldPresenter!

  override func awakeFromNib() {
    super.awakeFromNib()

    self.backgroundColor = .clear

    self.titleLabel.font = FormStyle.titleFont
    self.titleLabel.textColor = FormStyle.titleTextColor
    self.titleLabel.text = nil
    
    self.valueLabel.font = FormStyle.textFont
    self.valueLabel.textColor = FormStyle.inactiveTextColor
    self.valueLabel.text = nil
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
    self.valueLabel.textColor = FormStyle.activeTextColor

    return super.becomeFirstResponder()
  }
  
  @discardableResult
  override func resignFirstResponder() -> Bool {
    self.valueLabel.textColor = FormStyle.inactiveTextColor
    
    return super.resignFirstResponder()
  }
}

extension InputFormFieldView: FormFieldProtocol {

  var title: String? {
    get { return self.titleLabel.text }
    set { self.titleLabel.text = newValue }
  }

  var value: Any? {
    get { return self.presenter.value }
    set { self.presenter.value = newValue }
  }

  func setReturnKeyType(_ type: UIReturnKeyType) {
    self.returnKeyType = type
  }
}

extension InputFormFieldView: InputFormFieldViewProtocol {
  
  func updateValue(_ value: String?) {
    self.valueLabel.text = value
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
