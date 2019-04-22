import Quick
import Nimble

@testable import Kakebo

class ArrayGroupSpec: QuickSpec {
  override func spec() {
    
    it("when array is empty it should return empty") {
      let result = [Int]().group(by: { return $0 })
      
      expect(result.count).to(equal(0))
    }
    
    it("array of integers") {
      let result = [1, 2, 1].group(by: { return $0 })
      
      let expected = [1: [1, 1], 2: [2]]
      expect(result).to(equal(expected))
      expect(result.count).to(equal(2))
    }
    
  }
}
