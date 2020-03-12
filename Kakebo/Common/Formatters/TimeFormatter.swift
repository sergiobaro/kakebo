import Foundation

class TimeFormatter {
  
  private let maxLength = 4
  
  func trim(string: String) -> String {
    let result = string
      .components(separatedBy: CharacterSet.decimalDigits.inverted)
      .joined()
      .prefix(self.maxLength)

    return String(result)
  }
  
  func string(date: Date?) -> String {
    guard let date = date else {
      return "00:00"
    }
    let components = Calendar.current.dateComponents([.hour, .minute], from: date)
    let hour = String(components.hour ?? 0)
    let minute = String(components.minute ?? 0)
    
    let hourString = String(repeating: "0", count: max(2 - hour.count, 0)) + hour
    let minuteString = String(repeating: "0", count: max(2 - minute.count, 0)) + minute
    
    return hourString + ":" + minuteString
  }
  
  func string(string: String?) -> String {
    guard let string = string, !string.isEmpty, let integer = Int(string) else {
      return "00:00"
    }
    
    let value = String(integer).prefix(self.maxLength)
    let result = String(repeating: "0", count: self.maxLength - value.count) + value
    
    return result.prefix(2) + ":" + result.suffix(2)
  }
  
}
