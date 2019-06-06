import Foundation

protocol Validator {

  func isValid(_ value: Any?) -> Bool

}

class NotEmptyValidator: Validator {

  func isValid(_ value: Any?) -> Bool {
    if let string = value as? String {
      return !string.isEmpty
    }

    return (value != nil)
  }
}

class NotNilValidator: Validator {

  func isValid(_ value: Any?) -> Bool {
    return (value != nil)
  }
}
