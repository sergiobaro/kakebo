import Foundation

class AmountFormatter {
  
  private let numberFormatter: NumberFormatter = {
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .currency
    return numberFormatter
  }()
  
  func string(integer: Int) -> String {
    let number = (Double(integer) / 100) as NSNumber
    return self.numberFormatter.string(from: number) ?? ""
  }
  
  func string(string: String) -> String {
    return self.string(integer: Int(string) ?? 0)
  }
  
}
