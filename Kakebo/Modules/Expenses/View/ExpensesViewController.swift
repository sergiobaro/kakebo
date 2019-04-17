import UIKit

protocol ExpensesPresenter {
  
  func viewReady()
  func viewAppear()
  
  func numberOfExpenses() -> Int
  func expense(at index: Int) -> Expense?
  func deleteExpense(at index: Int) -> Bool
  
  func userTapAdd()
  
}

class ExpensesViewController: UIViewController {
  
  @IBOutlet private weak var tableView: UITableView!
  
  private let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .short
    dateFormatter.timeStyle = .none
    return dateFormatter
  }()
  
  private let numberFormatter: NumberFormatter = {
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .currency
    return numberFormatter
  }()

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
    
    self.tableView.register(ExpenseCell.self)
    
    self.tableView.allowsSelection = false
    self.tableView.dataSource = self
    self.tableView.delegate = self
    
    self.tableView.rowHeight = UITableView.automaticDimension
    self.tableView.estimatedRowHeight = ExpenseCell.height
    
    self.presenter.viewReady()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    self.presenter.viewAppear()
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
    let cell = tableView.dequeue(ExpenseCell.self, for: indexPath)!
    
    if let expense = self.presenter.expense(at: indexPath.row) {
      cell.nameLabel.text = expense.name
      cell.amountLabel.text = self.numberFormatter.string(from: expense.amount as NSNumber)
      cell.dateLabel.text = self.dateFormatter.string(from: expense.createdAt)
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
