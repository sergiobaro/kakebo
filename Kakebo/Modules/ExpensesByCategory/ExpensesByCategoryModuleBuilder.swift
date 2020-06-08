import UIKit

class ExpensesByCategoryModuleBuilder {

  private let expensesRepository: ExpensesRepository
  private let categoriesRepository: ExpenseCategoriesRepository

  init(expensesRepository: ExpensesRepository, categoriesRepository: ExpenseCategoriesRepository) {
    self.expensesRepository = expensesRepository
    self.categoriesRepository = categoriesRepository
  }

  func build() -> UIViewController? {
    let storyboard = UIStoryboard(name: "ExpensesByCategoryViewController", bundle: .main)
    guard let viewController = storyboard.instantiateInitialViewController() as? ExpensesByCategoryViewController else {
      return nil
    }

    viewController.presenter = ExpensesByCategoryPresenter(
      view: viewController,
      router: ExpensesByCategoryRouter(viewController: viewController),
      expensesRepository: self.expensesRepository,
      categoriesRepository: self.categoriesRepository
    )

    return UINavigationController(rootViewController: viewController)
  }
}
