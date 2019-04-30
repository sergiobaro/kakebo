import UIKit

extension UIView {
  
  static func loadFromNib<View: UIView>(type: View.Type) -> View {
    let nib = UINib(nibName: String(describing: View.self), bundle: nil)
    
    // swiftlint:disable:next force_cast
    return nib.instantiate(withOwner: nil, options: nil).first as! View
  }
}
