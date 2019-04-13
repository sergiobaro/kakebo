import UIKit

class ExpensesRouter {

  private weak var viewController: UIViewController?
  private let repository: ExpensesRepository

  init(viewController: UIViewController, repository: ExpensesRepository) {
    self.viewController = viewController
    self.repository = repository
  }

  func navigateToAddExpense() {
    guard let addExpense = AddExpenseModuleBuilder(repository: self.repository).build() else {
      return
    }
    
    self.viewController?.present(addExpense, animated: true)
  }
}
