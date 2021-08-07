import UIKit

struct DateRangeSelectorModel {
  let startDate: Date
  let endDate: Date
}

protocol DateRangeSelectorDelegate: AnyObject {
  func dateSelectorDidSelect(startDate: Date, endDate: Date)
}

class DateRangeSelectorModuleBuilder {

  private let repository: ExpensesRepository

  init(repository: ExpensesRepository) {
    self.repository = repository
  }

  func build(model: DateRangeSelectorModel, delegate: DateRangeSelectorDelegate) -> UIViewController? {
    guard let viewController = UIStoryboard.instantiate(type: DateRangeSelectorViewController.self, bundle: nil) else {
      return nil
    }

    viewController.presenter = DateRangeSelectorPresenter(
      model: model,
      view: viewController,
      delegate: delegate,
      router: DateRangeSelectorRouter(viewController: viewController),
      repository: repository
    )
    return UINavigationController(rootViewController: viewController)
  }
}
