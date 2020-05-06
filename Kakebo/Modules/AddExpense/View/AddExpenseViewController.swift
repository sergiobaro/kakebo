import UIKit

class AddExpenseViewController: UIViewController {

  private var formView: FormView?

  var presenter: AddExpensePresenter!
  
  // MARK: - View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.setupNavBar()
    
    self.presenter.viewIsReady()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    self.formView?.focus()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    self.formView?.blur()
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
  }
  
  // MARK: - Actions
  
  @objc func tapCancel() {
    self.presenter.userTapCancel()
  }
  
  @objc func tapSave() {
    self.presenter.userTapDone()
  }
}

extension AddExpenseViewController: FormViewDelegate {

  func formFieldDidChange(_ field: FormFieldModel) {
    guard let fields = self.formView?.allFields() else { return }
    self.presenter.userChanged(fields: fields)
  }

  func formDidFinish(with fields: [FormFieldModel]) {
    self.presenter.userTapDone()
  }

  func formDidSelect(_ field: FormFieldModel) {
    self.presenter.userDidSelectField(field)
  }
}

extension AddExpenseViewController: AddExpenseView {
  
  func display(title: String) {
    self.title = localize(title)
  }

  func display(fields: [FormFieldModel]) {
    self.formView?.removeFromSuperview()

    self.formView = FormBuilder()
      .add(fields: fields)
      .add(to: self.view, viewController: self)

    self.formView?.delegate = self
  }
  
  func displaySave(enabled: Bool) {
    self.navigationItem.rightBarButtonItem?.isEnabled = enabled
  }

  func currentFields() -> [FormFieldModel] {
    return self.formView?.allFields() ?? []
  }
}
