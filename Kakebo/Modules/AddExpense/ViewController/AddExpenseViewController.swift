import UIKit

class AddExpenseViewController: UIViewController {
  
  @IBOutlet weak var textField: UITextField!

  var presenter: AddExpensePresenter!
  
  // MARK: - View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.title = NSLocalizedString("Add Expense", comment: "")
    
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
    
    self.textField.delegate = self
    self.textField.becomeFirstResponder()
  }
  
  // MARK: - Actions
  
  @objc func tapCancel() {
    self.presenter.userTapCancel()
  }
  
  @objc func tapDone() {
    self.presenter.userTapDone(text: self.textField.text)
  }
}

extension AddExpenseViewController: UITextFieldDelegate {
  
  func textField(
    _ textField: UITextField,
    shouldChangeCharactersIn range: NSRange,
    replacementString string: String
  ) -> Bool {
    if string == "\n" {
      self.presenter.userTapDone(text: textField.text)
      return false
    }
    return true
  }
}
