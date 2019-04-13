import UIKit

class ExpensesModuleBuilder {
  
  private let repository: ExpensesRepository
  
  init(repository: ExpensesRepository) {
    self.repository = repository
  }
  
  func build() -> UIViewController? {
    let viewController = ExpensesViewController()
    
    let router = ExpensesRouter(viewController: viewController, repository: self.repository)
    let presenter = ExpensesPresenter(
      router: router,
      repository: repository
    )
    
    viewController.presenter = presenter
    
    return UINavigationController(rootViewController: viewController)
  }
  
}
