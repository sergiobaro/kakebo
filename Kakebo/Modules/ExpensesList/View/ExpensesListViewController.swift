import UIKit

struct ExpenseViewModel {
  
  let name: String
  let amount: String
  let date: String
  
}

struct ExpenseSectionViewModel {
  
  let title: String
  let totalAmount: String
  
}

protocol ExpensesListPresenter {
  
  func viewReady()
  func viewAppear()
  
  func numberOfSections() -> Int
  func numberOfExpenses(section: Int) -> Int
  func expenseSection(for section: Int) -> ExpenseSectionViewModel?
  func expense(at indexPath: IndexPath) -> ExpenseViewModel?
  func deleteExpense(at indexPath: IndexPath) -> Bool
  
  func userTapAdd()
  func userSelectExpense(indexPath: IndexPath)
  
}

class ExpensesListViewController: UIViewController {
  
  @IBOutlet private weak var tableView: UITableView!

  var presenter: ExpensesListPresenter!

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
    self.tableView.register(ExpensesListCell.self)
    
    self.tableView.dataSource = self
    self.tableView.delegate = self
    
    self.tableView.rowHeight = UITableView.automaticDimension
    self.tableView.estimatedRowHeight = ExpensesListCell.height
    
    self.tableView.sectionHeaderHeight = UITableView.automaticDimension
    self.tableView.estimatedSectionHeaderHeight = ExpensesListSectionHeader.height
    
    self.tableView.tableFooterView = UIView()
    self.tableView.separatorInset = .zero
  }
  
  // MARK: - Actions

  @objc func tapAdd() {
    self.presenter.userTapAdd()
  }
}

extension ExpensesListViewController: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return self.presenter.numberOfSections()
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    guard let expenseSection = self.presenter.expenseSection(for: section) else {
      return nil
    }
    
    let header = UIView.loadFromNib(type: ExpensesListSectionHeader.self)
    header.titleLabel.text = expenseSection.title
    header.amountLabel.text = expenseSection.totalAmount
    
    return header
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.presenter.numberOfExpenses(section: section)
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeue(ExpensesListCell.self, for: indexPath)!
    
    if let expense = self.presenter.expense(at: indexPath) {
      cell.nameLabel.text = expense.name
      cell.amountLabel.text = expense.amount
      cell.dateLabel.text = expense.date
    }
    
    return cell
  }
}

extension ExpensesListViewController: UITableViewDelegate {
  
  func tableView(
    _ tableView: UITableView,
    commit editingStyle: UITableViewCell.EditingStyle,
    forRowAt indexPath: IndexPath
  ) {
    guard editingStyle == .delete && self.presenter.deleteExpense(at: indexPath) else {
      return
    }
    
    if self.presenter.numberOfExpenses(section: indexPath.section) == 0 {
      self.tableView.deleteSection(at: indexPath.section, with: .left)
    } else {
      self.tableView.deleteRow(at: indexPath, with: .left)
    }
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    self.presenter.userSelectExpense(indexPath: indexPath)
  }
}
