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
  func deleteExpense(at indexPath: IndexPath)
  
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
    self.tableView.register(ExpensesListHeaderView.self)

    self.tableView.dataSource = self
    self.tableView.delegate = self
    
    self.tableView.rowHeight = UITableView.automaticDimension
    self.tableView.estimatedRowHeight = ExpensesListCell.height
    
    self.tableView.sectionHeaderHeight = ExpensesListHeaderView.height
    self.tableView.estimatedSectionHeaderHeight = ExpensesListHeaderView.height
    
    self.tableView.tableFooterView = UIView()
    self.tableView.separatorInset = .zero
    self.tableView.separatorColor = .separator
  }
  
  // MARK: - Actions

  @objc func tapAdd() {
    self.presenter.userTapAdd()
  }

  // MARK: - Private

  private func fill(header: ExpensesListHeaderView?, section: Int) {
    let expenseSection = self.presenter.expenseSection(for: section)
    header?.titleLabel.text = expenseSection?.title
    header?.amountLabel.text = expenseSection?.totalAmount
  }

  func refreshHeader(at section: Int) {
    let header = self.tableView.headerView(forSection: section) as? ExpensesListHeaderView
    self.fill(header: header, section: section)

    header?.setNeedsDisplay()
  }
}

extension ExpensesListViewController: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return self.presenter.numberOfSections()
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let header = tableView.dequeue(ExpensesListHeaderView.self)
    self.fill(header: header, section: section)

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

  // swiftlint:disable:next line_length
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      self.presenter.deleteExpense(at: indexPath)
    }
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    self.presenter.userSelectExpense(indexPath: indexPath)
  }
}

extension ExpensesListViewController: ExpensesListViewProtocol {

  func delete(section: Int) {
    self.tableView.deleteSection(at: section, with: .left)
  }

  func deleteRow(at indexPath: IndexPath) {
    self.tableView.deleteRow(at: indexPath, with: .left)
    self.refreshHeader(at: indexPath.section)
  }
}
