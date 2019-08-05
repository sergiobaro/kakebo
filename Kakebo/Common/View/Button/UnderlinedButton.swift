import UIKit

class UnderlinedButton: UIButton {

  var title: String? {
    didSet {
      self.setTitle(title)
    }
  }

  private func setTitle(_ title: String?) {
    guard let title = title else {
      super.setTitle(nil, for: .normal)
      super.setTitle(nil, for: .highlighted)
      return
    }

    self.setTitle(title, color: .black, state: .normal)
    self.setTitle(title, color: .textMedium, state: .highlighted)
  }

  private func setTitle(_ title: String, color: UIColor, state: UIControl.State) {
    let attributedTitle = NSAttributedString(
      string: title,
      attributes: [
        .font: UIFont.medium,
        .underlineStyle: NSUnderlineStyle.single.rawValue,
        .foregroundColor: color
      ]
    )

    self.setAttributedTitle(attributedTitle, for: state)
  }
}
