import Quick
import Nimble

@testable import Kakebo

class ArrayElementSpec: QuickSpec {
  override func spec() {
    it("empty array") {
      var array = [Int]()

      expect(array.isValid(index: 0)).to(beFalse())
      expect(array.element(at: -1)).to(beNil())
      expect(array.element(at: 0)).to(beNil())
      expect(array.removeElement(at: 0)).to(beNil())
    }

    it("array with elements") {
      var array = [1, 2, 3]

      expect(array.isValid(index: 0)).to(beTrue())
      expect(array.isValid(index: 3)).to(beFalse())
      expect(array.isValid(index: 1)).to(beTrue())

      expect(array.element(at: 0)).to(equal(1))
      expect(array.element(at: -1)).to(beNil())
      expect(array.element(at: 3)).to(beNil())

      expect(array.removeElement(at: 0)).to(equal(1))
      
    }
  }
}
