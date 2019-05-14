import UIKit

protocol AddExpensePresenter {
  
  func viewIsReady()
  
  func userTapDone()
  func userTapCancel()
  func userChanged(name: String?) -> Bool
  func userChanged(amount: Int?)
  func userChanged(createdAt: Date?)
  
}

class AddExpenseViewController: UIViewController {

  private var formView: FormView!

  var presenter: AddExpensePresenter!
  
  // MARK: - View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.setupNavBar()
    self.setupForm()
    
    self.presenter.viewIsReady()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    self.formView.becomeFirstResponder()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    self.formView.resignFirstResponder()
  }
  
  // MARK: - Setup
  
  private func setupNavBar() {
    self.navigationItem.leftBarButtonItem = UIBarButtonItem(
      barButtonSystemItem: .cancel,
      target: self,
      action: #selector(tapCancel)
    )
    
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(
      barButtonSystemItem: .save,
      target: self,
      action: #selector(tapSave)
    )

    self.navigationController?.navigationBar.isTranslucent = false
  }
  
  private func setupForm() {
    let nameField = FormFieldModel(
      type: .text,
      identifier: "name",
      title: localize("Name"),
      value: ""
    )
    let amountField = FormFieldModel(
      type: .amount,
      identifier: "amount",
      title: localize("Amount"),
      value: 0
    )

    self.formView = FormBuilder()
      .add(field: nameField)
      .add(field: amountField)
      .add(to: self.view)
  }
  
  // MARK: - Actions
  
  @objc func tapCancel() {
    self.presenter.userTapCancel()
  }
  
  @objc func tapSave() {
    self.presenter.userTapDone()
  }
}

//extension AddExpenseViewController: AmountFieldDelegate {
//
//  func amountField(_ amountField: AmountField, didChangeValue value: Int?) {
//    self.presenter.userChanged(amount: value)
//  }
//
//  func amountField(_ amountField: AmountField, didFinishEditingWithValue value: Int?) {
//    self.presenter.userChanged(amount: value)
//    self.dateField.becomeFirstResponder()
//  }
//}

//extension AddExpenseViewController: DateFieldDelegate {
//
//  func dateField(_ dateField: DateField, didChangeValue value: Date?) {
//    self.presenter.userChanged(createdAt: value)
//  }
//
//  func dateField(_ dateField: DateField, didFinishEditingWithValue value: Date?) {
//    self.presenter.userChanged(createdAt: value)
//    self.presenter.userTapDone()
//  }
//}

extension AddExpenseViewController: AddExpenseView {
  
  func display(title: String) {
    self.title = localize(title)
  }
  
  func display(expense: Expense) {
//    self.nameTextField.text = expense.name
//    self.amountField.value = expense.amount
//    self.dateField.value = expense.createdAt
  }
  
  func displayDone(enabled: Bool) {
    self.navigationItem.rightBarButtonItem?.isEnabled = enabled
  }
  
  func currentName() -> String? {
    return self.formView.value(for: "name") as? String
  }
  
  func currentAmount() -> Int? {
    return self.formView.value(for: "amount") as? Int
  }
  
  func currentCreatedAt() -> Date? {
    return self.formView.value(for: "date") as? Date
  }
}
