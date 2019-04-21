import XCTest
@testable import Kakebo

class ExpenseDateFormatterTests: XCTestCase {
  
  let formatter = ExpenseDateFormatter()
  
  func test_string() {
    XCTAssertEqual(self.formatter.string(string: ""), "")
    
    XCTAssertEqual(self.formatter.string(string: "0"), "0")
    XCTAssertEqual(self.formatter.string(string: "1"), "1")
    
    XCTAssertEqual(self.formatter.string(string: "01"), "01 / ")
    XCTAssertEqual(self.formatter.string(string: "10"), "10 / ")
    XCTAssertEqual(self.formatter.string(string: "123"), "12 / 3")
    XCTAssertEqual(self.formatter.string(string: "1230"), "12 / 30 / ")
    
    XCTAssertEqual(self.formatter.string(string: "123020"), "12 / 30 / 20")
    XCTAssertEqual(self.formatter.string(string: "12302019"), "12 / 30 / 2019")
    
    XCTAssertEqual(self.formatter.string(string: "12302019000"), "12 / 30 / 2019")
  }
  
  func test_trim() {
    XCTAssertEqual(self.formatter.trim(string: ""), "")
    
    XCTAssertEqual(self.formatter.trim(string: "123456"), "123456")
    
    XCTAssertEqual(self.formatter.trim(string: "123456789"), "12345678")
  }
}
