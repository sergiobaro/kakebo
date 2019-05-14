import Foundation

enum FormFieldType {
  case text
  case amount
  case date
}

struct FormFieldModel {
  var type: FormFieldType
  let identifier: String
  let title: String?
  var value: Any?
}

extension FormFieldModel: Equatable {

  static func == (lhs: FormFieldModel, rhs: FormFieldModel) -> Bool {
    return lhs.identifier == rhs.identifier
  }
}
