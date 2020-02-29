import Foundation

extension Date {
  
  func keepingComponents(_ components: Set<Calendar.Component>) -> Date? {
    let components = Calendar.current.dateComponents(components, from: self)
    return Calendar.current.date(from: components)
  }
  
  func addingComponents(_ components: DateComponents) -> Date? {
    Calendar.current.date(byAdding: components, to: self)
  }
}
