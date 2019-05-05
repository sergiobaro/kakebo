import Quick
import Nimble

@testable import Kakebo

class StringReplacingSpec: QuickSpec {
  override func spec() {
    it("empty string should not replace") {
      let string = ""

      let result = string.replacing(in: NSRange(location: 0, length: 1), with: " ")

      expect(result).to(equal(""))
    }

    it("empty string should replace the beginning") {
      let string = ""

      let result = string.replacing(in: NSRange(location: 0, length: 0), with: " ")

      expect(result).to(equal(" "))
    }

    it("non empty string length 1 should replace") {
      let string = "abcd"

      let result = string.replacing(in: NSRange(location: 1, length: 1), with: " ")

      expect(result).to(equal("a cd"))
    }

    it("non aempty string lenght 0 should add") {
      let string = "abcd"

      let result = string.replacing(in: NSRange(location: 1, length: 0), with: " ")

      expect(result).to(equal("a bcd"))
    }

    it("length bigger than string should not replace") {
      let string = "abcd"

      let result = string.replacing(in: NSRange(location: 1, length: 5), with: " ")

      expect(result).to(equal("abcd"))
    }

    it("location bigger than string") {
      let string = "abcd"

      let result = string.replacing(in: NSRange(location: 5, length: 1), with: " ")

      expect(result).to(equal("abcd"))
    }
  }
}
