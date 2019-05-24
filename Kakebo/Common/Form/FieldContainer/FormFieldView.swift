import UIKit

class FormFieldView: UIView {

  weak var container: FormFieldContainer?

  func focus() {
    // to override
  }

  func blur() {
    // to override
  }

  func setReturnKeyType(_ type: UIReturnKeyType) {
    // to override
  }
}
