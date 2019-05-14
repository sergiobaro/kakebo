import Foundation

enum FormFieldType {
  case text(String?)
  case amount(Int?)
}

struct FormFieldModel {
  var type: FormFieldType
  let identifier: String
  let title: String?
}

extension FormFieldModel: Equatable {

  static func == (lhs: FormFieldModel, rhs: FormFieldModel) -> Bool {
    return lhs.identifier == rhs.identifier
  }

}
