import Quick
import Nimble

@testable import Kakebo

class TimeFormatterSpec: QuickSpec {
  override func spec() {
    
    var timeFormatter: TimeFormatter!
    
    beforeEach {
      timeFormatter = TimeFormatter()
    }

    context("time") {
      it("from string") {
        expect(timeFormatter.string(string: nil)).to(equal("00:00"))
        expect(timeFormatter.string(string: "")).to(equal("00:00"))
        expect(timeFormatter.string(string: "1")).to(equal("00:01"))
        expect(timeFormatter.string(string: "12")).to(equal("00:12"))
        expect(timeFormatter.string(string: "123")).to(equal("01:23"))
        expect(timeFormatter.string(string: "1234")).to(equal("12:34"))
        expect(timeFormatter.string(string: "12345")).to(equal("12:34"))
        
        expect(timeFormatter.string(string: "001")).to(equal("00:01"))
        expect(timeFormatter.string(string: "000001")).to(equal("00:01"))
      }
  
      it("from date") {
        expect(timeFormatter.string(date: nil)).to(equal("00:00"))
        
        expect(timeFormatter.string(date: date(hour: 0, minute: 0))).to(equal("00:00"))
        expect(timeFormatter.string(date: date(hour: 12, minute: 12))).to(equal("12:12"))
        expect(timeFormatter.string(date: date(hour: 23, minute: 59))).to(equal("23:59"))
        expect(timeFormatter.string(date: date(hour: 8, minute: 8))).to(equal("08:08"))
      }
    }
    
    func date(hour: Int, minute: Int) -> Date? {
      let components = DateComponents(hour: hour, minute: minute)
      let date = Calendar.current.date(from: components)
      
      return date
    }

  }
}
