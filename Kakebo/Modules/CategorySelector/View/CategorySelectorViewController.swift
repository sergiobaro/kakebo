import UIKit

class CategorySelectorViewController: UIViewController {

  @IBOutlet private weak var tableView: UITableView!

  var presenter: CategorySelectorPresenter!

  private var categories = [ExpenseCategoryViewModel]()

  override func viewDidLoad() {
    super.viewDidLoad()

    self.title = localize("Categories")

    self.navigationItem.rightBarButtonItem = UIBarButtonItem(
      barButtonSystemItem: .add,
      target: self,
      action: #selector(tapAdd)
    )
    self.navigationItem.leftBarButtonItem = UIBarButtonItem(
      barButtonSystemItem: .done,
      target: self,
      action: #selector(tapDone)
    )

    self.tableView.allowsMultipleSelection = true
    self.tableView.delegate = self
    self.tableView.dataSource = self
    
    self.presenter.viewIsReady()
  }

  @objc private func tapAdd() {
    self.presenter.userAddCategory()
  }

  @objc private func tapDone() {
    self.presenter.userDone()
  }

}

extension CategorySelectorViewController: UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    self.categories.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeue(cell: CategorySelectorCell.self, indexPath: indexPath)

    if let category = categories.element(at: indexPath.row) {
      cell.nameLabel.text = category.name
      if category.isSelected {
        tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
      }
    }
    
    return cell
  }
}

extension CategorySelectorViewController: UITableViewDelegate {

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    self.presenter.userDidSelectCategory(self.categories[indexPath.row])
  }

  func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    self.presenter.userDidDeselectCategory(self.categories[indexPath.row])
  }

  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    true
  }

  // swiftlint:disable:next line_length
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    guard editingStyle == .delete else { return }
    guard let category = self.categories.element(at: indexPath.row) else { return }

    self.presenter.userDidDeleteCategory(category)
    self.categories.remove(at: indexPath.row)

    tableView.deleteRow(at: indexPath, with: .left)
  }
}

extension CategorySelectorViewController: CategorySelectorView {

  func showCategories(_ categories: [ExpenseCategoryViewModel]) {
    self.categories = categories
    self.tableView.reloadData()
  }
}
