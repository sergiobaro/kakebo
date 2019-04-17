import UIKit

struct ExpenseViewModel {
  
  let name: String
  let amount: String
  let date: String
  
}

protocol ExpensesPresenter {
  
  func viewReady()
  func viewAppear()
  
  func numberOfExpenses() -> Int
  func expense(at index: Int) -> ExpenseViewModel?
  func deleteExpense(at index: Int) -> Bool
  
  func userTapAdd()
  
}

class ExpensesViewController: UIViewController {
  
  @IBOutlet private weak var tableView: UITableView!

  var presenter: ExpensesPresenter!

  // MARK: - View lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.setupNavBar()
    self.setupTableView()
    
    self.presenter.viewReady()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    self.presenter.viewAppear()
    self.tableView.reloadData()
  }

  // MARK: - Setup
  
  private func setupNavBar() {
    self.title = localize("Expenses")
    
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(
      barButtonSystemItem: .add,
      target: self,
      action: #selector(tapAdd)
    )
  }
  
  private func setupTableView() {
    self.tableView.register(ExpenseCell.self)
    
    self.tableView.allowsSelection = false
    self.tableView.dataSource = self
    self.tableView.delegate = self
    
    self.tableView.rowHeight = UITableView.automaticDimension
    self.tableView.estimatedRowHeight = ExpenseCell.height
    
    self.tableView.tableFooterView = UIView()
    self.tableView.separatorInset = .zero
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
    let cell = tableView.dequeue(ExpenseCell.self, for: indexPath)!
    
    if let expense = self.presenter.expense(at: indexPath.row) {
      cell.nameLabel.text = expense.name
      cell.amountLabel.text = expense.amount
      cell.dateLabel.text = expense.date
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
