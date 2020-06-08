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

    self.tableView.dataSource = self
    self.tableView.allowsSelection = false

    presenter.viewIsReady()
  }

  @objc private func tapClose() {
    self.dismiss(animated: true)
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
    var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
    if cell == nil {
      cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
    }

    let viewModel = self.viewModels[indexPath.row]
    cell?.textLabel?.text = viewModel.categoryName
    cell?.detailTextLabel?.text = viewModel.amount

    return cell!
  }
}
