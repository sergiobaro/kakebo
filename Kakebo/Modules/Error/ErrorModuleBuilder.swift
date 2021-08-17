import UIKit
import SwiftUI

class ErrorModuleBuilder {
  func build(error: Error) -> UIViewController {
    let view = ErrorView(errorDescription: error.localizedDescription)
    let viewController = UIHostingController(rootView: view)
    return UINavigationController(rootViewController: viewController)
  }
}
