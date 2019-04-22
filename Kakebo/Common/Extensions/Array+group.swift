import Foundation

extension Array {
  
  func group<T: Hashable>(by grouping: (Element) -> T) -> [T: [Element]] {
    var result = [T: [Element]]()
    
    self.forEach({ element in
      let groupBy = grouping(element)
      
      var group = result[groupBy] ?? [Element]()
      group.append(element)
      result[groupBy] = group
    })
    
    return result
  }
}
