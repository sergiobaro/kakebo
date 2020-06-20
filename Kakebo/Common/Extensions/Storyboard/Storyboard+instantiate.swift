import UIKit

extension UIStoryboard {

  static func instantiate<ViewController: UIViewController>(
    type: ViewController.Type,
    bundle: Bundle?
  ) -> ViewController? {
    let identifier = String(describing: type)
    let storyboard = UIStoryboard(name: identifier, bundle: bundle)
    return storyboard.instantiate(type: type)
  }

  func instantiate<ViewController: UIViewController>(type: ViewController.Type) -> ViewController? {
    let identifier = String(describing: type)
    return self.instantiateViewController(identifier: identifier) as? ViewController
  }
}
