import Foundation

class DefaultExpenseListPresenter {

  private let router: ExpenseListRouter

  init(router: ExpenseListRouter) {
    self.router = router
  }
}

extension DefaultExpenseListPresenter: ExpenseListPresenter {

  func userTapAdd() {
    self.router.navigateToAddExpense()
  }
}
