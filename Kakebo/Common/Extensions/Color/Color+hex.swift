import UIKit

extension UIColor {

  static func from(hex: Int) -> UIColor {
    let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
    let green = CGFloat((hex & 0x00FF00) >> 8) / 255.0
    let blue = CGFloat((hex & 0x0000FF) >> 0) / 255.0

    return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
  }
  
}
