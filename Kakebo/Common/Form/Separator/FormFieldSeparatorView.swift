import UIKit

class FormFieldSeparatorView: UIView {

  static func make() -> UIView {
    let separator = UIView()
    separator.backgroundColor = .lightGray

    separator.snp.makeConstraints({ $0.height.equalTo(0.5) })

    return separator
  }
}
