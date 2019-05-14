import UIKit

protocol FormFieldDelegate: class {

  func fieldDidChange(_ field: FormFieldModel)
  func fieldDidEndEditing(_ field: FormFieldModel)
  
}

typealias FormField = FormFieldProtocol & FormFieldView

protocol FormFieldProtocol: class {

  var title: String? { get set }
  var value: Any? { get set }

  func setReturnKeyType(_ type: UIReturnKeyType)

}

class FormFieldView: UIView {

  weak var formDelegate: FormFieldDelegate?
  var field: FormFieldModel!

}
