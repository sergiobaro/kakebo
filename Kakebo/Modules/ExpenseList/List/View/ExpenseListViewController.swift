import UIKit

class ExpenseListViewController: UIViewController {

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
//    self.presenter.userTapAdd()
  }
}

extension ExpenseListViewController: ExpenseListSelectorViewDelegate {

  func expenseSelectorViewDidSelectDay(_ expenseListSelectorView: ExpenseListSelectorView) {
    print("Day")
  }

  func expenseSelectorViewDidSelectMonth(_ expenseListSelectorView: ExpenseListSelectorView) {
    print("Month")
  }
}
