import UIKit

typealias FormField = FormFieldView & FormFieldViewProtocol

protocol FormFieldViewProtocol: class {

  func focus()
  func blur()
  func setReturnKeyType(_ type: UIReturnKeyType)

}

class FormFieldView: UIView {

  weak var formDelegate: FormFieldDelegate?
  var field: FormFieldModel!

}
