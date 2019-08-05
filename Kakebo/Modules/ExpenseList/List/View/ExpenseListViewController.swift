import UIKit
import SnapKit

protocol ExpenseListPresenter {

  func hasExpenses() -> Bool

  func userTapAdd()

}

class ExpenseListViewController: UIViewController {

  @IBOutlet private weak var scrollView: UIScrollView!

  private var emptyView: EmptyStateView!

  var presenter: ExpenseListPresenter!
  var dayListViewController: UIViewController!
  var monthListViewController: UIViewController!

  // MARK: - View lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.setupNavBar()
    self.setupEmptyView()
    self.setupScrollView()
    self.setupDayList()
    self.setupMonthList()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    self.emptyView.isHidden = self.presenter.hasExpenses()
    self.scrollView.isHidden = !self.emptyView.isHidden
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

  private func setupEmptyView() {
    let emptyView = UIView.loadFromNib(type: EmptyStateView.self)
    emptyView.setMessage(localize("You don't have any expense"))
    emptyView.setButton(title: localize("Add expense")) { [weak self] in
      self?.presenter.userTapAdd()
    }

    self.view.addSubview(emptyView)
    emptyView.snp.makeConstraints { (maker) in
      maker.top.left.right.equalToSuperview()
      maker.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
    }

    self.emptyView = emptyView
  }

  private func setupScrollView() {
    self.scrollView.isScrollEnabled = false
    self.scrollView.clipsToBounds = false

    self.scrollView.contentSize = CGSize(
      width: self.view.frame.width * 2.0,
      height: self.view.frame.height
    )
  }

  private func setupDayList() {
    self.addChild(self.dayListViewController)
    self.scrollView.setPage(0, view: self.dayListViewController.view)
    self.dayListViewController.didMove(toParent: self)
  }

  private func setupMonthList() {
    self.addChild(self.monthListViewController)
    self.scrollView.setPage(1, view: self.monthListViewController.view)
    self.monthListViewController.didMove(toParent: self)
  }
  
  // MARK: - Actions

  @objc func tapAdd() {
    self.presenter.userTapAdd()
  }
}

extension ExpenseListViewController: ExpenseListSelectorViewDelegate {

  func expenseListSelectorViewDidSelect(type: ExpenseListSelectorViewType) {
    switch type {
    case .day:
      self.scrollView.scrollTo(page: 0, animated: true)
    case .month:
      self.scrollView.scrollTo(page: 1, animated: true)
    }
  }
}
