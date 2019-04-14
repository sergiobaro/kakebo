import UIKit

class ExpensesModuleBuilder {
  
  private let repository: ExpensesRepository
  
  init(repository: ExpensesRepository) {
    self.repository = repository
  }
  
  func build() -> UIViewController? {
    let viewController = ExpensesViewController()
    
    let router = ExpensesRouter(
      viewController: viewController,
      addExpensesModuleBuilder: AddExpenseModuleBuilder(repository: self.repository)
    )
    
    viewController.presenter = DefaultExpensesPresenter(
      router: router,
      repository: repository
    )
    
    return UINavigationController(rootViewController: viewController)
  }
  
}
