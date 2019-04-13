import UIKit

class AddExpenseModuleBuilder {
  
  private let repository: ExpensesRepository
  
  init(repository: ExpensesRepository) {
    self.repository = repository
  }
  
  func build() -> UIViewController? {
    let viewController = AddExpenseViewController()
    
    let router = AddExpenseRouter(viewController: viewController)
    let presenter = AddExpensePresenter(router: router, repository: self.repository)
    
    viewController.presenter = presenter
    
    return UINavigationController(rootViewController: viewController)
  }
  
}
