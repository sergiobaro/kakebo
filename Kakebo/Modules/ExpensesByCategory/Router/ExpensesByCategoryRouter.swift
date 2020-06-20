import UIKit

class ExpensesByCategoryRouter {

  private weak var viewController: UIViewController?
  private let dateRangeSelectorModuleBuilder: DateRangeSelectorModuleBuilder

  init(viewController: UIViewController, dateRangeSelectorModuleBuilder: DateRangeSelectorModuleBuilder) {
    self.viewController = viewController
    self.dateRangeSelectorModuleBuilder = dateRangeSelectorModuleBuilder
  }

  func navigateToDateRangeSelector(model: DateRangeSelectorModel, delegate: DateRangeSelectorDelegate) {
    guard let dateRangeSelector = self.dateRangeSelectorModuleBuilder.build(model: model, delegate: delegate) else {
      return
    }
    
    self.viewController?.present(dateRangeSelector, animated: true)
  }

  func navigateBack() {
    self.viewController?.dismiss(animated: true)
  }
}
