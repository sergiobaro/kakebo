import UIKit
import SwiftUI

class ImportedFileModuleBuilder {

  func build(file: ImportFile) -> UINavigationController {
    let view = ImportFileView(presenter: ImportFilePresenter(file: file))
    let viewController = UIHostingController(rootView: view)
    return UINavigationController(rootViewController: viewController)
  }
}
