import UIKit

class ExpensesByCategoryRouter {

  private weak var viewController: UIViewController?
  private let dateRangeSelectorModuleBuilder: DateRangeSelectorModuleBuilder

  init(viewController: UIViewController, dateRangeSelectorModuleBuilder: DateRangeSelectorModuleBuilder) {
    self.viewController = viewController
    self.dateRangeSelectorModuleBuilder = dateRangeSelectorModuleBuilder
  }

  func navigateToDateRangeSelector(delegate: DateRangeSelectorDelegate) {
    guard let dateRangeSelector = self.dateRangeSelectorModuleBuilder.build(delegate: delegate) else { return }
    self.viewController?.present(dateRangeSelector, animated: true)
  }

  func navigateBack() {
    self.viewController?.dismiss(animated: true)
  }
}
