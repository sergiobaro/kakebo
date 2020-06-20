import Foundation

extension Date {

  func startOfMonth() -> Date {
    let components = Calendar.current.dateComponents([.year, .month], from: self)
    return Calendar.current.date(from: components)!
  }

  func endOfMonth() -> Date {
    var components = Calendar.current.dateComponents([.year, .month], from: self)
    components.month! += 1
    components.day = 0

    return Calendar.current.date(from: components)!
  }
}
