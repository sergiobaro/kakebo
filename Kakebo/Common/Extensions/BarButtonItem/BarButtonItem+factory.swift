import UIKit

@objc protocol CloseBarButtonDelegate {
  func tapClose()
}

@objc protocol CancelBarButtonDelegate {
  func tapCancel()
}

@objc protocol SaveBarButtonDelegate {
  func tapSave()
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

  static func cancel(delegate: CancelBarButtonDelegate) -> UIBarButtonItem {
    .init(barButtonSystemItem: .cancel, target: delegate, action: #selector(delegate.tapCancel))
  }

  static func save(delegate: SaveBarButtonDelegate) -> UIBarButtonItem {
    .init(barButtonSystemItem: .save, target: delegate, action: #selector(delegate.tapSave))
  }
}
