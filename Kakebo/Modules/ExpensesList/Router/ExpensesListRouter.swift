import UIKit

class ExpensesListRouter {

  private weak var viewController: UIViewController?
  private let addExpensesModuleBuilder: AddExpenseModuleBuilder

  init(viewController: UIViewController, addExpensesModuleBuilder: AddExpenseModuleBuilder) {
    self.viewController = viewController
    self.addExpensesModuleBuilder = addExpensesModuleBuilder
  }

  func navigateToAddExpense() {
    guard let addExpense = self.addExpensesModuleBuilder.build() else {
      return
    }
    
    self.viewController?.present(addExpense, animated: true)
  }
}
