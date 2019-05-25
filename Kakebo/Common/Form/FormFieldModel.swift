import Foundation

enum FormFieldType {
  case text
  case amount
  case date
  case time
}

class FormFieldModel {
  var type: FormFieldType
  let identifier: String
  let title: String?
  var value: Any?

  init(type: FormFieldType, identifier: String, title: String?, value: Any?) {
    self.type = type
    self.identifier = identifier
    self.title = title
    self.value = value
  }
}

extension FormFieldModel: Equatable {

  static func == (lhs: FormFieldModel, rhs: FormFieldModel) -> Bool {
    return lhs.identifier == rhs.identifier
  }
}
