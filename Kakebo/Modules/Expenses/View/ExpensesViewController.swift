import UIKit

protocol ExpensesPresenter {
  
  func numberOfExpenses() -> Int
  func expense(at index: Int) -> Expense?
  func deleteExpense(at index: Int) -> Bool
  
  func userTapAdd()
  
}

class ExpensesViewController: UIViewController {
  
  @IBOutlet private weak var tableView: UITableView!

  var presenter: ExpensesPresenter!

  // MARK: - View lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()

    self.title = localize("Expenses")
    
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(
      barButtonSystemItem: .add,
      target: self,
      action: #selector(tapAdd)
    )
    
    self.tableView.allowsSelection = false
    self.tableView.dataSource = self
    self.tableView.delegate = self
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    self.tableView.reloadData()
  }

  // MARK: - Actions

  @objc func tapAdd() {
    self.presenter.userTapAdd()
  }
}

extension ExpensesViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.presenter.numberOfExpenses()
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var cell: UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: "cell")
    if cell == nil {
      cell = UITableViewCell(style: .value2, reuseIdentifier: "cell")
    }
    
    if let expense = self.presenter.expense(at: indexPath.row) {
      cell.textLabel?.text = expense.name
      cell.detailTextLabel?.text = String(expense.amount)
    }
    
    return cell
  }
  
}

extension ExpensesViewController: UITableViewDelegate {
  
  func tableView(
    _ tableView: UITableView,
    commit editingStyle: UITableViewCell.EditingStyle,
    forRowAt indexPath: IndexPath
  ) {
    if editingStyle == .delete {
      if self.presenter.deleteExpense(at: indexPath.row) {
        self.tableView.deleteRows(at: [indexPath], with: .left)
      }
    }
  }
}
