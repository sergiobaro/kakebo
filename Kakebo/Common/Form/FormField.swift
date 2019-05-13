import Foundation

enum FormFieldType {
  case text(String?)
}

struct FormField {
  var type: FormFieldType
  let identifier: String
  let title: String?
  let placeholder: String?
}

extension FormField: Equatable {

  static func == (lhs: FormField, rhs: FormField) -> Bool {
    return lhs.identifier == rhs.identifier
  }

}
