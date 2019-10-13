import UIKit

struct FormStyle {

  // colors
  static let titleTextColor = UIColor.darkGray
  static let textColor = UIColor.black

  static let borderActiveColor = UIColor.darkGray
  static let borderInactiveColor = UIColor.lightGray
  static let borderErrorColor = UIColor.red

  // fonts
  static let titleFont = UIFont.systemFont(ofSize: 14.0)
  static let textFont = UIFont.systemFont(ofSize: 16.0)

  // dimensions
  static let margin = CGFloat(6.0)
  static let fieldHeight = CGFloat(45.0)
  static let borderActiveWidth = CGFloat(1.0)
  static let borderInactiveWidth = CGFloat(0.5)
  
  // custom keyboard
  static let customKeyboardHeight = CGFloat(335.0)
  static let customKeyboardAnimationDuration = TimeInterval(0.25)
  static let customKeyboardBackgroundColor = UIColor.groupTableViewBackground
  
}
