import Foundation

extension String {
  
  func replacing(in range: NSRange, with string: String) -> String {
    guard let textRange = Range(range, in: self) else {
      return String(self)
    }
    
    return self.replacingCharacters(in: textRange, with: string)
  }
}
