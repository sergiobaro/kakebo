import UIKit

class ExpensesModuleBuilder {

  private let repository: ExpensesRepository
  private let addExpenseModuleBuilder: AddExpenseModuleBuilder
  private let expenseListModuleBuilder: ExpenseListModuleBuilder
  private let expensesByCategoryModuleBuilder: ExpensesByCategoryModuleBuilder

  init(
    repository: ExpensesRepository,
    addExpenseModuleBuilder: AddExpenseModuleBuilder,
    expenseListModuleBuilder: ExpenseListModuleBuilder,
    expensesByCategoryModuleBuilder: ExpensesByCategoryModuleBuilder
  ) {
    self.repository = repository
    self.addExpenseModuleBuilder = addExpenseModuleBuilder
    self.expenseListModuleBuilder = expenseListModuleBuilder
    self.expensesByCategoryModuleBuilder = expensesByCategoryModuleBuilder
  }
  
  func build() -> UIViewController? {
    let viewController = ExpensesViewController()
    
    let router = ExpensesRouter(
      viewController: viewController,
      addExpenseModuleBuilder: self.addExpenseModuleBuilder,
      expenseListModuleBuilder: self.expenseListModuleBuilder,
      expensesByCategoryModuleBuilder: self.expensesByCategoryModuleBuilder
    )

    let presenter = ExpensesPresenter(
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
      delegate: presenter,
      repository: repository
    )

    return UINavigationController(rootViewController: viewController)
  }

  // MARK: - Private
  
  private func makeDayList(
    delegate: DayExpenseListDelegate,
    repository: ExpensesRepository
  ) -> ExpenseListViewController {
    let viewController = ExpenseListViewController()

    viewController.presenter = DayExpenseListPresenter(
      view: viewController,
      delegate: delegate,
      repository: repository
    )

    return viewController
  }

  private func makeMonthList(
    delegate: MonthExpenseListDelegate,
    repository: ExpensesRepository
  ) -> ExpenseListViewController {
    let viewController = ExpenseListViewController()

    viewController.presenter = MonthExpenseListPresenter(
      view: viewController,
      delegate: delegate,
      repository: repository
    )

    return viewController
  }
  
}
