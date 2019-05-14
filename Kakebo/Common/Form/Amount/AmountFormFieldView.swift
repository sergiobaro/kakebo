import UIKit

protocol AmountFormFieldPresenter {

  var formDelegate: FormFieldDelegate? { get set }
  var field: FormFieldModel! { get set }

  var value: Int? { get set }
  var hasText: Bool { get }

  func userInsertText(_ text: String)
  func userDeleteBackward()

}

class AmountFormFieldView: FormFieldView {

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

  private var presenter: AmountFormFieldPresenter!

  override func awakeFromNib() {
    super.awakeFromNib()

    self.backgroundColor = .clear

    self.titleLabel.font = UIFont.systemFont(ofSize: 14.0)
    self.titleLabel.textColor = .darkGray
    self.titleLabel.text = nil
    self.valueLabel.font = UIFont.systemFont(ofSize: 18.0)
    self.valueLabel.textColor = .darkGray
    self.valueLabel.text = nil

    self.presenter = AmountFormFieldDefaultPresenter(view: self)
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
    self.valueLabel.textColor = .darkGray
    
    return super.resignFirstResponder()
  }
}

extension AmountFormFieldView: FormFieldProtocol {

  var title: String? {
    get { return self.titleLabel.text }
    set { self.titleLabel.text = newValue }
  }

  var value: Any? {
    get { return self.presenter.value }
    set { self.presenter.value = newValue as? Int }
  }

  func setReturnKeyType(_ type: UIReturnKeyType) {
    self.returnKeyType = type
  }
}

extension AmountFormFieldView: AmountFormFieldViewProtocol {
  
  func updateValue(_ value: String?) {
    self.valueLabel.text = value
  }
}

extension AmountFormFieldView: UIKeyInput {
  
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
