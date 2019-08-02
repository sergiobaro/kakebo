import UIKit

protocol ExpenseListPresenter {

  func userTapAdd()

}

class ExpenseListViewController: UIViewController {

  var presenter: ExpenseListPresenter!

  // MARK: - View lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.setupNavBar()
  }

  // MARK: - Setup
  
  private func setupNavBar() {
    self.title = localize("Expenses")
    
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(
      barButtonSystemItem: .add,
      target: self,
      action: #selector(tapAdd)
    )

    let expenseListSelectorView = UIView.loadFromNib(type: ExpenseListSelectorView.self)
    expenseListSelectorView.delegate = self
    self.navigationItem.titleView = expenseListSelectorView
  }
  
  // MARK: - Actions

  @objc func tapAdd() {
    self.presenter.userTapAdd()
  }
}

extension ExpenseListViewController: ExpenseListSelectorViewDelegate {

  func expenseListSelectorViewDidSelect(type: ExpenseListSelectorViewType) {
    print(type.rawValue)
  }
}
