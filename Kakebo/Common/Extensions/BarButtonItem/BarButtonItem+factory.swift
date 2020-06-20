import UIKit

@objc protocol CloseBarButtonDelegate {
  func tapClose()
}

extension UIBarButtonItem {

  static func close(delegate: CloseBarButtonDelegate) -> UIBarButtonItem {
    .init(
      image: UIImage(systemName: "xmark"),
      style: .plain,
      target: delegate,
      action: #selector(delegate.tapClose)
    )
  }
}
