import Foundation

enum FormFieldType {
  case text
  case amount
  case date
  case time
  case calendar
}

class FormFieldModel {
  var type: FormFieldType
  let identifier: String
  let title: String?
  let validators: [Validator]
  var value: Any?

  init(type: FormFieldType, identifier: String, title: String?, validators: [Validator], value: Any?) {
    self.type = type
    self.identifier = identifier
    self.title = title
    self.validators = validators
    self.value = value
  }
}

extension FormFieldModel: Equatable {

  static func == (lhs: FormFieldModel, rhs: FormFieldModel) -> Bool {
    return lhs.identifier == rhs.identifier
  }
}
