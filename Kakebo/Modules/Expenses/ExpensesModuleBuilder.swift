import UIKit

class ExpensesModuleBuilder {
  
  func build(repository: ExpensesRepository) -> UIViewController? {
    let viewController = ExpensesViewController()
    
    let router = ExpenseListRouter(
      viewController: viewController,
      addExpenseModuleBuilder: AddExpenseModuleBuilder(repository: repository)
    )

    viewController.presenter = DefaultExpensesPresenter(
      router: router,
      repository: repository
    )

    viewController.dayListViewController = self.makeDayList(
      router: router,
      repository: repository
    )

    viewController.monthListViewController = self.makeMonthList(
      router: router,
      repository: repository
    )

    return UINavigationController(rootViewController: viewController)
  }

  private func makeDayList(router: ExpenseListRouter, repository: ExpensesRepository) -> UIViewController {
    let viewController = ExpenseListViewController()

    viewController.presenter = DayExpenseListPresenter(
      view: viewController,
      router: router,
      repository: repository
    )

    return viewController
  }

  private func makeMonthList(router: ExpenseListRouter, repository: ExpensesRepository) -> UIViewController {
    let viewController = ExpenseListViewController()

    viewController.presenter = MonthExpenseListPresenter(
      repository: repository
    )

    return viewController
  }
  
}
