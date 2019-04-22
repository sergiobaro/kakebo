import Quick
import Nimble

@testable import Kakebo

class AmountFormatterSpec: QuickSpec {
  override func spec() {
    
    let formatter = AmountFormatter()
    
    it("format string") {
      expect(formatter.string(string: "")).to(equal("$0.00"))
      expect(formatter.string(string: "0")).to(equal("$0.00"))
      
      expect(formatter.string(string: "1")).to(equal("$0.01"))
      expect(formatter.string(string: "10")).to(equal("$0.10"))
      expect(formatter.string(string: "100")).to(equal("$1.00"))
      expect(formatter.string(string: "1234")).to(equal("$12.34"))
      expect(formatter.string(string: "12345")).to(equal("$123.45"))
    }
    
    it("format int") {
      expect(formatter.string(integer: 0)).to(equal("$0.00"))
      
      expect(formatter.string(integer: 1)).to(equal("$0.01"))
      expect(formatter.string(integer: 10)).to(equal("$0.10"))
      expect(formatter.string(integer: 100)).to(equal("$1.00"))
      expect(formatter.string(integer: 1234)).to(equal("$12.34"))
      expect(formatter.string(integer: 12345)).to(equal("$123.45"))
    }
    
  }
}
