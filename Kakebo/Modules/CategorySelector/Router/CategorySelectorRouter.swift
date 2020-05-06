import UIKit

class CategorySelectorRouter {

  private weak var viewController: UIViewController?

  init(viewController: UIViewController) {
    self.viewController = viewController
  }

  func navigateToAddCategory(delegate: AddCategoryDelegate) {
    let viewController = AddCategoryModuleBuilder().build(delegate: delegate)
    self.viewController?.present(viewController, animated: true)
  }

  func navigateBack() {
    self.viewController?.navigationController?.popViewController(animated: true)
  }
}
