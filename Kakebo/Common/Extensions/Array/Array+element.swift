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
    return (index >= self.startIndex && index < self.endIndex)
  }
}
