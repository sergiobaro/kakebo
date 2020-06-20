import UIKit

class ExpensesByCategoryModuleBuilder {

  private let expensesRepository: ExpensesRepository
  private let categoriesRepository: ExpenseCategoriesRepository
  private let dateRangeSelectorModuleBuilder: DateRangeSelectorModuleBuilder

  init(
    expensesRepository: ExpensesRepository,
    categoriesRepository: ExpenseCategoriesRepository,
    dateRangeSelectorModuleBuilder: DateRangeSelectorModuleBuilder
  ) {
    self.expensesRepository = expensesRepository
    self.categoriesRepository = categoriesRepository
    self.dateRangeSelectorModuleBuilder = dateRangeSelectorModuleBuilder
  }

  func build() -> UIViewController? {
    let storyboard = UIStoryboard(name: "ExpensesByCategoryViewController", bundle: .main)
    guard let viewController = storyboard.instantiateInitialViewController() as? ExpensesByCategoryViewController else {
      return nil
    }

    viewController.presenter = ExpensesByCategoryPresenter(
      view: viewController,
      router: ExpensesByCategoryRouter(
        viewController: viewController,
        dateRangeSelectorModuleBuilder: self.dateRangeSelectorModuleBuilder
      ),
      expensesRepository: self.expensesRepository,
      categoriesRepository: self.categoriesRepository
    )

    return UINavigationController(rootViewController: viewController)
  }
}
