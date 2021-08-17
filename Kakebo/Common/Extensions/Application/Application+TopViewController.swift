import UIKit

extension UIApplication {
  var topViewController: UIViewController {
    let keyWindow: UIWindow! = windows.first { $0.isKeyWindow }
    var topViewController = keyWindow.rootViewController!
    while let presentedViewController = topViewController.presentedViewController {
      topViewController = presentedViewController
    }

    return topViewController
  }
}
