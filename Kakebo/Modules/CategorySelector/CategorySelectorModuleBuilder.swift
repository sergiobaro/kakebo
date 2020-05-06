import UIKit

protocol CategorySelectorDelegate: class {
  func didSelectCategories(_ categories: [ExpenseCategory])
}

class CategorySelectorModuleBuilder {

  private let repository: ExpenseCategoriesRepository

  init(repository: ExpenseCategoriesRepository) {
    self.repository = repository
  }

  func build(selectedCategories: [ExpenseCategory], delegate: CategorySelectorDelegate) -> UIViewController {
    let viewController = CategorySelectorViewController()
    viewController.presenter = CategorySelectorPresenter(
      view: viewController,
      delegate: delegate,
      selectedCategories: selectedCategories,
      router: CategorySelectorRouter(viewController: viewController),
      repository: self.repository
    )

    return viewController
  }
}
