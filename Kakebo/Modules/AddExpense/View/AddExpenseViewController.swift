import UIKit

protocol AddExpensePresenter {
  
  func viewIsReady()
  
  func userTapDone()
  func userTapCancel()
  func userChanged(name: String?) -> Bool
  func userChanged(amount: Int?)
  
}

class AddExpenseViewController: UIViewController {
  
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var amountView: AmountView!

  var presenter: AddExpensePresenter!
  
  // MARK: - View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.setupNavBar()
    self.setupTextFields()
    
    self.presenter.viewIsReady()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    self.nameTextField.becomeFirstResponder()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    self.view.endEditing(true)
  }
  
  // MARK: - Setup
  
  private func setupNavBar() {
    self.title = localize("Add Expense")
    
    self.navigationItem.leftBarButtonItem = UIBarButtonItem(
      barButtonSystemItem: .cancel,
      target: self,
      action: #selector(tapCancel)
    )
    
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(
      barButtonSystemItem: .done,
      target: self,
      action: #selector(tapDone)
    )
  }
  
  private func setupTextFields() {
    self.nameTextField.placeholder = localize("Name")
    self.nameTextField.delegate = self
    self.nameTextField.autocapitalizationType = .sentences
    
    self.amountView.placeholder = localize("Amount")
    self.amountView.delegate = self
  }
  
  // MARK: - Actions
  
  @objc func tapCancel() {
    self.presenter.userTapCancel()
  }
  
  @objc func tapDone() {
    self.presenter.userTapDone()
  }
}

extension AddExpenseViewController: UITextFieldDelegate {
  
  func textField(
    _ textField: UITextField,
    shouldChangeCharactersIn range: NSRange,
    replacementString string: String
  ) -> Bool {
    if string == "\n" {
      self.amountView.becomeFirstResponder()
      return false
    }
    
    let text = textField.text?.replacing(in: range, with: string)
    return self.presenter.userChanged(name: text)
  }
}

extension AddExpenseViewController: AmountViewDelegate {
  
  func amountView(_ amountView: AmountView, didChangeValue value: Int?) {
    self.presenter.userChanged(amount: value)
  }
}

extension AddExpenseViewController: AddExpenseView {
  
  func done(enabled: Bool) {
    self.navigationItem.rightBarButtonItem?.isEnabled = enabled
  }
  
  func currentName() -> String? {
    return self.nameTextField.text
  }
  
  func currentAmount() -> Int? {
    return self.amountView.value
  }
}
