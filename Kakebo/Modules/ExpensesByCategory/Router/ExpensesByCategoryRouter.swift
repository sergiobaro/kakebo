import UIKit

class ExpensesByCategoryRouter {

  private weak var viewController: UIViewController?

  init(viewController: UIViewController) {
    self.viewController = viewController
  }

  func navigateToFilter() {

  }

  func navigateBack() {
    self.viewController?.dismiss(animated: true)
  }
}
