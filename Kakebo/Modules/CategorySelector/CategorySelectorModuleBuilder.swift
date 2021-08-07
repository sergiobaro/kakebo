import UIKit

protocol CategorySelectorDelegate: AnyObject {
  func didSelectCategories(_ categories: [ExpenseCategory])
}

class CategorySelectorModuleBuilder {

  private let repository: ExpenseCategoriesRepository

  init(repository: ExpenseCategoriesRepository) {
    self.repository = repository
  }

  func build(selectedCategories: [ExpenseCategory], delegate: CategorySelectorDelegate) -> UIViewController? {
    let storyboard = UIStoryboard(name: "CategorySelectorViewController", bundle: .main)
    guard let viewController = storyboard.instantiateInitialViewController() as? CategorySelectorViewController else {
      return nil
    }

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
