import UIKit

class ExpenseListRouter {
  
  private weak var viewController: UIViewController?
  
  init(viewController: UIViewController) {
    self.viewController = viewController
  }
  
  func navigateBack() {
    self.viewController?.dismiss(animated: true)
  }
}
