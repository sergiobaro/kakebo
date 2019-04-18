import Foundation

class AmountFormatter {
  
  private let numberFormatter: NumberFormatter = {
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .currency
    return numberFormatter
  }()
  
  func formatInt(from integer: Int) -> String {
    let number = (Double(integer) / 100) as NSNumber
    return self.numberFormatter.string(from: number) ?? ""
  }
  
  func formatString(from string: String) -> String {
    return self.formatInt(from: Int(string) ?? 0)
  }
  
}
