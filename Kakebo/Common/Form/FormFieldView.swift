import UIKit

protocol FieldFormDelegate: class {

  func fieldDidChange(_ field: FormField)
  func fieldDidEndEditing(_ field: FormField)
  
}

class FormFieldView: UIView {

  weak var formDelegate: FieldFormDelegate?
  var field: FormField!
  var value: Any?

  func setReturnKeyType(_ type: UIReturnKeyType) {
    // override
  }
}
