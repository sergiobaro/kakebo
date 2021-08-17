import UIKit

class ImportRouter {

  func present(file: ImportFile) {
    let viewController = ImportedFileModuleBuilder().build(file: file)
    UIApplication.shared.topViewController.present(viewController, animated: true)
  }

  func present(error: Error) {
    let viewController = ErrorModuleBuilder().build(error: error)
    UIApplication.shared.topViewController.present(viewController, animated: true)
  }
}
