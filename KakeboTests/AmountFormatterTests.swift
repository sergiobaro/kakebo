import XCTest
@testable import Kakebo

class AmountFormatterTests: XCTestCase {
  
  let formatter = AmountFormatter()
  
  func test_formatString() {
    XCTAssertEqual(self.formatter.formatString(from: ""), "$0.00")
    XCTAssertEqual(self.formatter.formatString(from: "0"), "$0.00")
    
    XCTAssertEqual(self.formatter.formatString(from: "1"), "$0.01")
    XCTAssertEqual(self.formatter.formatString(from: "10"), "$0.10")
    XCTAssertEqual(self.formatter.formatString(from: "100"), "$1.00")
    XCTAssertEqual(self.formatter.formatString(from: "1234"), "$12.34")
    XCTAssertEqual(self.formatter.formatString(from: "12345"), "$123.45")
  }
  
  func test_formatInt() {
    XCTAssertEqual(self.formatter.formatInt(from: 0), "$0.00")
    
    XCTAssertEqual(self.formatter.formatInt(from: 1), "$0.01")
    XCTAssertEqual(self.formatter.formatInt(from: 10), "$0.10")
    XCTAssertEqual(self.formatter.formatInt(from: 100), "$1.00")
    XCTAssertEqual(self.formatter.formatInt(from: 1234), "$12.34")
    XCTAssertEqual(self.formatter.formatInt(from: 12345), "$123.45")
  }
}
