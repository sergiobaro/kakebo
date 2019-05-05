import Foundation

extension Array {
  
  func group<T: Hashable>(by grouping: (Element) -> T) -> [T: [Element]] {
    return self.reduce(into: [T: [Element]]()) { result, element in
      let groupBy = grouping(element)
      
      var group = result[groupBy] ?? [Element]()
      group.append(element)
      result[groupBy] = group
    }
  }
}
