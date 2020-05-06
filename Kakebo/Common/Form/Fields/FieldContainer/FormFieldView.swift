import UIKit

class FormFieldView: UIView {

  weak var formDelegate: FormFieldDelegate?
  weak var formController: FormController?

  var field: FormFieldModel!

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
