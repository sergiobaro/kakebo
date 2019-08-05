import UIKit

class ExpenseDayListModuleBuilder {

  func make(router: ExpenseListRouter, repository: ExpensesRepository) -> UIViewController {
    let viewController = ExpenseDayListViewController()

    viewController.presenter = DefaultExpenseDayListPresenter(
      view: viewController,
      router: router,
      repository: repository
    )

    return viewController
  }
}
