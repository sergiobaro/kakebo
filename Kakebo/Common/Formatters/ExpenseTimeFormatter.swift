import Foundation

class ExpenseTimeFormatter {

  private let separator = " : "
  private let maxLength = 4

  private let dateFormatter: DateFormatter

  var dateFormat: String {
    return self.dateFormatter.dateFormat.uppercased()
  }

  init() {
    self.dateFormatter = DateFormatter()
    self.dateFormatter.dateFormat = "HH : mm"
  }

  // MARK: - Public

  func date(string: String) -> Date? {
    guard string.count == self.maxLength else {
      return nil
    }

    let string = self.string(string: string)
    return self.dateFormatter.date(from: string)
  }

  func trim(string: String) -> String {
    let result = string
      .components(separatedBy: CharacterSet.decimalDigits.inverted)
      .joined()
      .prefix(self.maxLength)

    return String(result)
  }

  func string(string: String?) -> String {
    guard
      let string = string,
      !string.isEmpty else {
        return ""
    }

    if string.count == 1 {
      return string
    }
    if string.count == 2 {
      return string + self.separator
    }

    if string.count == 3 {
      return string[...1] + self.separator + string[2...]
    }

    if string.count <= self.maxLength {
      return string[...1] + self.separator + string[2...3]
    }

    return string[...1] + self.separator + string[2..<self.maxLength]
  }

  func string(date: Date) -> String {
    return self.dateFormatter.string(from: date)
  }
}
