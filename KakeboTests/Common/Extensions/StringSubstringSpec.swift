import Quick
import Nimble

@testable import Kakebo

class StringSubstringSpec: QuickSpec {
  override func spec() {

    it("Subscript") {
      let string = "abcd"

      expect(string[0...1]).to(equal("ab"))
      expect(string[3...]).to(equal("d"))
      
      expect(string[1..<3]).to(equal("bc"))

      expect(string[...2]).to(equal("abc"))
      expect(string[..<2]).to(equal("ab"))
    }
  }
}
