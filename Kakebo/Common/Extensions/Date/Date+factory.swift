import Foundation

extension Date {

  func startOfMonth() -> Date {
    let now = Date()
    let components = Calendar.current.dateComponents([.year, .month], from: now)
    return Calendar.current.date(from: components)!
  }

  func endOfMonth() -> Date {
    let now = Date()
    var components = Calendar.current.dateComponents([.year, .month], from: now)
    components.month! += 1
    components.day = 0

    return Calendar.current.date(from: components)!
  }
}
