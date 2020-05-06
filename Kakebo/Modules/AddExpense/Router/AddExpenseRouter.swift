import UIKit

class AddExpenseRouter {
  
  private weak var viewController: UIViewController?
  private let categorySelectorModuleBuilder: CategorySelectorModuleBuilder
  
  init(
    viewController: UIViewController,
    categorySelectorModuleBuilder: CategorySelectorModuleBuilder
  ) {
    self.viewController = viewController
    self.categorySelectorModuleBuilder = categorySelectorModuleBuilder
  }
  
  func navigateBack() {
    self.viewController?.dismiss(animated: true)
  }

  func navigateToCategorySelector(selectedCategories: [ExpenseCategory], delegate: CategorySelectorDelegate) {
    let viewController = self.categorySelectorModuleBuilder.build(
      selectedCategories: selectedCategories,
      delegate: delegate
    )

    self.viewController?.navigationController?.pushViewController(viewController, animated: true)
  }
}
