import UIKit

protocol ExpenseListDelegate: class {
  func didDeleteExpense(_ expense: Expense)
}

class ExpenseListModuleBuilder {
  
  private let repository: ExpensesRepository
  
  init(repository: ExpensesRepository) {
    self.repository = repository
  }
  
  func buildExpenseList(for date: Date, delegate: ExpenseListDelegate) -> UINavigationController? {
    let viewController = ExpenseListViewController()
    let router = ExpenseListRouter(viewController: viewController)
    let presenter = OnDateExpenseListPresenter(
      view: viewController,
      date: date,
      repository: self.repository,
      router: router,
      delegate: delegate
    )
    
    viewController.presenter = presenter
    viewController.standalonePresenter = presenter
    
    return UINavigationController(rootViewController: viewController)
  }
}
