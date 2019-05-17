import Foundation

class GeneralDateFormatter {

  private let fields: [String]
  private let separator: String
  private let maxLength: Int
  private let dateFormatter: DateFormatter

  var format: String {
    return self.dateFormatter.dateFormat.uppercased()
  }

  init(fields: [String], separator: String) {
    self.fields = fields
    self.separator = separator
    self.maxLength = fields.reduce(0) { $0 + $1.count }

    self.dateFormatter = DateFormatter()
    self.dateFormatter.dateFormat = fields.joined(separator: separator)
  }

  func trim(string: String) -> String {
    let result = string
      .components(separatedBy: CharacterSet.decimalDigits.inverted)
      .joined()
      .prefix(self.maxLength)

    return String(result)
  }

  func date(string: String) -> Date? {
    guard string.count == self.maxLength else {
      return nil
    }

    let string = self.string(string: string)
    return self.dateFormatter.date(from: string)
  }

  func string(string: String?) -> String {
    guard let string = string else {
        return ""
    }

    var result = ""
    var currentFieldIndex = 0
    var currentStringIndex = 0

    while currentStringIndex < string.count && currentFieldIndex < self.fields.count {
      let field = self.fields[currentFieldIndex]
      let startIndex = currentStringIndex
      let endIndex = currentStringIndex + field.count

      if endIndex <= string.count && currentFieldIndex < fields.count - 1 {
        result += string[startIndex..<endIndex] + self.separator
      } else {
        let end = min(string.count, endIndex)
        result += string[startIndex..<end]
      }

      currentStringIndex += field.count
      currentFieldIndex += 1
    }

    return result
  }

  func string(date: Date) -> String {
    return self.dateFormatter.string(from: date)
  }

}
