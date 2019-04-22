import XCTest
@testable import Kakebo

class AmountFormatterTests: XCTestCase {
  
  let formatter = AmountFormatter()
  
  func test_formatString() {
    XCTAssertEqual(self.formatter.string(string: ""), "$0.00")
    XCTAssertEqual(self.formatter.string(string: "0"), "$0.00")
    
    XCTAssertEqual(self.formatter.string(string: "1"), "$0.01")
    XCTAssertEqual(self.formatter.string(string: "10"), "$0.10")
    XCTAssertEqual(self.formatter.string(string: "100"), "$1.00")
    XCTAssertEqual(self.formatter.string(string: "1234"), "$12.34")
    XCTAssertEqual(self.formatter.string(string: "12345"), "$123.45")
  }
  
  func test_formatInt() {
    XCTAssertEqual(self.formatter.string(integer: 0), "$0.00")
    
    XCTAssertEqual(self.formatter.string(integer: 1), "$0.01")
    XCTAssertEqual(self.formatter.string(integer: 10), "$0.10")
    XCTAssertEqual(self.formatter.string(integer: 100), "$1.00")
    XCTAssertEqual(self.formatter.string(integer: 1234), "$12.34")
    XCTAssertEqual(self.formatter.string(integer: 12345), "$123.45")
  }
}
