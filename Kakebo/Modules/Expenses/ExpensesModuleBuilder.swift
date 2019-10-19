import UIKit

class ExpensesModuleBuilder {
  
  func build(repository: ExpensesRepository) -> UIViewController? {
    let viewController = ExpensesViewController()
    
    let router = ExpensesRouter(
      viewController: viewController,
      addExpenseModuleBuilder: AddExpenseModuleBuilder(repository: repository)
    )

    let presenter = DefaultExpensesPresenter(
      view: viewController,
      router: router,
      repository: repository
    )

    viewController.presenter = presenter
    
    viewController.dayListViewController = self.makeDayList(
      delegate: presenter,
      repository: repository
    )

    viewController.monthListViewController = self.makeMonthList(
      repository: repository
    )

    return UINavigationController(rootViewController: viewController)
  }

  // MARK: - Private
  
  private func makeDayList(delegate: ExpenseListDelegate, repository: ExpensesRepository) -> ExpenseListViewController {
    let viewController = ExpenseListViewController()

    viewController.presenter = DayExpenseListPresenter(
      view: viewController,
      delegate: delegate,
      repository: repository
    )

    return viewController
  }

  private func makeMonthList(repository: ExpensesRepository) -> ExpenseListViewController {
    let viewController = ExpenseListViewController()

    viewController.presenter = MonthExpenseListPresenter(
      view: viewController,
      repository: repository
    )

    return viewController
  }
  
}
