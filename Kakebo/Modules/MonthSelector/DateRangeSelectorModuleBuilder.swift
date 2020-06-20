import UIKit

protocol DateRangeSelectorDelegate: class {
  func dateSelectorDidSelect(startDate: Date, endDate: Date)
}

class DateRangeSelectorModuleBuilder {

  private let repository: ExpensesRepository

  init(repository: ExpensesRepository) {
    self.repository = repository
  }

  func build(delegate: DateRangeSelectorDelegate) -> UIViewController? {
    guard let viewController = UIStoryboard.instantiate(type: DateRangeSelectorViewController.self, bundle: nil) else {
      return nil
    }

    viewController.presenter = DateRangeSelectorPresenter(view: viewController, repository: repository)
    return UINavigationController(rootViewController: viewController)
  }
}
