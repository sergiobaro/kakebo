import Foundation

class TimeValidator: Validator {
  
  func isValid(_ value: Any?) -> Bool {
    guard let string = value as? String else {
      return false
    }
    guard string.count == 5 else {
      return false
    }
    
    let components = string.split(separator: ":")
    guard components.count == 2 else {
      return false
    }
    
    guard let hour = Int(components[0]),
      let minutes = Int(components[1]) else {
        return false
    }
    
    if hour > 23 || minutes > 59 {
      return false
    }
    
    return true
  }
}
