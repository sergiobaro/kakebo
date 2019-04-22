import XCTest
@testable import Kakebo

class ArrayGroupTests: XCTestCase {
  
  func test() {
    let result = [1, 2, 1].group(by: { return $0 })
    
    XCTAssertEqual([1: [1, 1], 2: [2]], result)
  }
}
