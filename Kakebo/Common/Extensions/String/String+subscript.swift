import Foundation

extension String {
  
  subscript(bounds: CountableClosedRange<Int>) -> String {
    let start = self.index(self.startIndex, offsetBy: bounds.lowerBound)
    let end = self.index(self.startIndex, offsetBy: bounds.upperBound)
    
    return String(self[start...end])
  }
  
  subscript(bounds: CountableRange<Int>) -> String {
    let start = self.index(self.startIndex, offsetBy: bounds.lowerBound)
    let end = self.index(self.startIndex, offsetBy: bounds.upperBound)
    
    return String(self[start..<end])
  }
  
  subscript(bounds: PartialRangeFrom<Int>) -> String {
    let start = self.index(self.startIndex, offsetBy: bounds.lowerBound)
    
    return String(self[start...])
  }
  
  subscript(bounds: PartialRangeUpTo<Int>) -> String {
    let end = self.index(self.startIndex, offsetBy: bounds.upperBound)
    
    return String(self[..<end])
  }
  
  subscript(bounds: PartialRangeThrough<Int>) -> String {
    let end = self.index(self.startIndex, offsetBy: bounds.upperBound)
    
    return String(self[...end])
  }
}
