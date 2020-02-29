import UIKit

protocol ExpenseListViewProtocol: class {

  func reloadData()
  func delete(section: Int)
  func deleteRow(at indexPath: IndexPath)
}

protocol ExpenseListStandalonePresenter {
  
  func title() -> String?
  func userTapClose()
}

protocol ExpenseListPresenter {

  func viewIsReady()
  func reloadExpenses()

  func numberOfSections() -> Int
  func numberOfExpenses(section: Int) -> Int
  func expenseSection(for section: Int) -> ExpenseListSectionViewModel?
  func expense(at indexPath: IndexPath) -> ExpenseListViewModel?
  func canSelect(at indexPath: IndexPath) -> Bool
  func canDelete(at indexPath: IndexPath) -> Bool
  func deleteExpense(at indexPath: IndexPath)

  func userSelectExpense(indexPath: IndexPath)
}

class ExpenseListViewController: UIViewController {

  @IBOutlet private weak var tableView: UITableView!

  var presenter: ExpenseListPresenter!
  var standalonePresenter: ExpenseListStandalonePresenter?

  // MARK: - View lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()

    self.setupNavigationBar()
    self.setupTableView()
    
    self.presenter.viewIsReady()
    self.title = self.standalonePresenter?.title()
  }

  // MARK: - Setup
  
  private func setupNavigationBar() {
    self.navigationItem.rightBarButtonItem = .init(
      title: "Close",
      style: .plain,
      target: self,
      action: #selector(tapClose)
    )
  }

  private func setupTableView() {
    self.tableView.register(ExpenseListCell.self)
    self.tableView.register(ExpenseListHeaderView.self)

    self.tableView.dataSource = self
    self.tableView.delegate = self

    self.tableView.rowHeight = UITableView.automaticDimension
    self.tableView.estimatedRowHeight = ExpenseListCell.height

    self.tableView.tableFooterView = UIView()
    self.tableView.separatorInset = .zero
    self.tableView.separatorColor = .separator
    self.tableView.clipsToBounds = false
  }
  
  // MARK: - Action
  
  @objc private func tapClose() {
    self.standalonePresenter?.userTapClose()
  }

  // MARK: - Private

  private func fill(header: ExpenseListHeaderView, expenseSection: ExpenseListSectionViewModel) {
    header.titleLabel.text = expenseSection.title
    header.amountLabel.text = expenseSection.totalAmount
  }

  func refreshHeader(at section: Int) {
    guard let expenseSection = self.presenter.expenseSection(for: section),
      let header = self.tableView.headerView(forSection: section) as? ExpenseListHeaderView else {
        return
    }
    
    self.fill(header: header, expenseSection: expenseSection)
    header.setNeedsDisplay()
  }
}

extension ExpenseListViewController: UITableViewDataSource {

  func numberOfSections(in tableView: UITableView) -> Int {
    return self.presenter.numberOfSections()
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    guard let expenseSection = self.presenter.expenseSection(for: section),
      let header = tableView.dequeue(ExpenseListHeaderView.self) else {
        return nil
    }

    self.fill(header: header, expenseSection: expenseSection)

    return header
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.presenter.numberOfExpenses(section: section)
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeue(ExpenseListCell.self, for: indexPath)!
    cell.selectionStyle = self.presenter.canSelect(at: indexPath) ? .default : .none

    if let expense = self.presenter.expense(at: indexPath) {
      cell.nameLabel.text = expense.name
      cell.amountLabel.text = expense.amount
      cell.dateLabel.text = expense.date
    }

    return cell
  }
}

extension ExpenseListViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    if self.presenter.expenseSection(for: section) == nil {
      return 0
    } else {
      return ExpenseListHeaderView.height
    }
  }

  func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
    return self.presenter.canDelete(at: indexPath) ? .delete : .none
  }

  // swiftlint:disable:next line_length
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      self.presenter.deleteExpense(at: indexPath)
    }
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    self.presenter.userSelectExpense(indexPath: indexPath)
    tableView.deselectRow(at: indexPath, animated: true)
  }
}

extension ExpenseListViewController: ExpenseListViewProtocol {
  
  func reloadData() {
    self.tableView.reloadData()
  }

  func delete(section: Int) {
    self.tableView.deleteSection(at: section, with: .left)
  }

  func deleteRow(at indexPath: IndexPath) {
    self.tableView.deleteRow(at: indexPath, with: .left)
    self.refreshHeader(at: indexPath.section)
  }
}
