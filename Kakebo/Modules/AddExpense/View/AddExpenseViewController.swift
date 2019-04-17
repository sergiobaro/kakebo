import UIKit

protocol AddExpensePresenter {
  
  func viewIsReady()
  
  func userTapDone()
  func userTapCancel()
  func userChanged(name: String?) -> Bool
  func userChanged(amount: String?) -> Bool
  
}

class AddExpenseViewController: UIViewController {
  
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var amountTextField: UITextField!

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
    self.nameTextField.keyboardType = .default
    self.nameTextField.autocapitalizationType = .sentences
    
    self.amountTextField.placeholder = localize("Amount")
    self.amountTextField.delegate = self
    self.amountTextField.keyboardType = .numberPad
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
      if textField == self.nameTextField {
        self.amountTextField.becomeFirstResponder()
      } else if textField == self.amountTextField {
        self.presenter.userTapDone()
      }
    }
    
    let text = textField.text?.replacing(in: range, with: string)
    
    if textField == self.nameTextField {
      return self.presenter.userChanged(name: text)
    } else if textField == self.amountTextField {
      return self.presenter.userChanged(amount: text)
    }
    
    return true
  }
}

extension AddExpenseViewController: AddExpenseView {
  
  func done(enabled: Bool) {
    self.navigationItem.rightBarButtonItem?.isEnabled = enabled
  }
  
  func currentName() -> String? {
    return self.nameTextField.text
  }
  
  func currentAmount() -> String? {
    return self.amountTextField.text
  }
}
