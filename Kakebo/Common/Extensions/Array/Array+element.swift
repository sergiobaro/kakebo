import Foundation

extension Array {
  
  func element(at index: Int) -> Element? {
    guard self.isValid(index: index) else {
      return nil
    }
    
    return self[index]
  }
  
  mutating func removeElement(at index: Int) -> Element? {
    guard self.isValid(index: index) else {
      return nil
    }

    return self.remove(at: index)
  }
  
  func isValid(index: Int) -> Bool {
    self.indices.contains(index)
  }
}

extension Array where Element: Equatable {

  mutating func remove(_ element: Element) {
    guard let index = self.firstIndex(of: element) else {
      return
    }

    self.remove(at: index)
  }
}
