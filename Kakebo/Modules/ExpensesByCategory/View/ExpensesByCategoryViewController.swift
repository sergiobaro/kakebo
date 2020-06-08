import UIKit

class ExpensesByCategoryViewController: UIViewController {

  @IBOutlet private weak var tableView: UITableView!

  private var viewModels = [ExpensesByCategoryViewModel]()

  var presenter: ExpensesByCategoryPresenter!

  override func viewDidLoad() {
    super.viewDidLoad()

    self.title = localize("Expenses By Category")

    self.navigationItem.leftBarButtonItem = UIBarButtonItem(
      image: UIImage(systemName: "xmark"),
      style: .plain,
      target: self,
      action: #selector(tapClose)
    )

    self.navigationItem.rightBarButtonItem = UIBarButtonItem(
      image: UIImage(systemName: "line.horizontal.3.decrease"),
      style: .plain,
      target: self,
      action: #selector(tapFilter)
    )

    self.tableView.dataSource = self
    self.tableView.allowsSelection = false

    presenter.viewIsReady()
  }

  @objc private func tapClose() {
    self.presenter.userTapClose()
  }

  @objc private func tapFilter() {
    self.presenter.userTapFilter()
  }
}

extension ExpensesByCategoryViewController: ExpensesByCategoryView {
  func showViewModels(_ viewModels: [ExpensesByCategoryViewModel]) {
    self.viewModels = viewModels
    self.tableView.reloadData()
  }
}

extension ExpensesByCategoryViewController: UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    self.viewModels.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeue(cell: ExpensesByCategoryCell.self, indexPath: indexPath)

    let viewModel = self.viewModels[indexPath.row]
    cell.nameLabel.text = viewModel.categoryName
    cell.amountLabel.text = viewModel.amount

    return cell
  }
}
