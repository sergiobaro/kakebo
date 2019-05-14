import UIKit

class FormFieldSeparatorView: UIView {

  static func make() -> UIView {
    let separator = UIView()
    separator.backgroundColor = FormStyle.separatorColor

    separator.snp.makeConstraints({ $0.height.equalTo(FormStyle.separatorHeight) })

    return separator
  }
}
