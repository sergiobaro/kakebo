import UIKit

class AddExpenseRouter {
  
  private weak var viewController: UIViewController?
  
  init(viewController: UIViewController) {
    self.viewController = viewController
  }
  
  func navigateBack() {
    self.viewController?.dismiss(animated: true)
  }
}
