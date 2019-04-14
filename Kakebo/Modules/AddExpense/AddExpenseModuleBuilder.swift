import UIKit

class AddExpenseModuleBuilder {
  
  private let repository: ExpensesRepository
  
  init(repository: ExpensesRepository) {
    self.repository = repository
  }
  
  func build() -> UIViewController? {
    let viewController = AddExpenseViewController()
    
    let router = AddExpenseRouter(viewController: viewController)
    
    viewController.presenter = DefaultAddExpensePresenter(
      view: viewController,
      router: router,
      repository: self.repository
    )
    
    return UINavigationController(rootViewController: viewController)
  }
  
}
