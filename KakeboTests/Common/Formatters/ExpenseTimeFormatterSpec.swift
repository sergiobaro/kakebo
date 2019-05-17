import Quick
import Nimble

@testable import Kakebo

class ExpenseTimeFormatterSpec: QuickSpec {
  override func spec() {

    let formatter = ExpenseTimeFormatter()

    it("format string") {
      expect(formatter.string(string: "")).to(equal(""))

      expect(formatter.string(string: "0")).to(equal("0"))
      expect(formatter.string(string: "1")).to(equal("1"))

      expect(formatter.string(string: "01")).to(equal("01 : "))
      expect(formatter.string(string: "10")).to(equal("10 : "))
      expect(formatter.string(string: "123")).to(equal("12 : 3"))
      expect(formatter.string(string: "1230")).to(equal("12 : 30"))

      expect(formatter.string(string: "123020")).to(equal("12 : 30"))
    }

    it("trim string") {
      expect(formatter.trim(string: "")).to(equal(""))

      expect(formatter.trim(string: "123456")).to(equal("1234"))

      expect(formatter.trim(string: "123456789")).to(equal("1234"))
    }

    it("date from string") {
      expect(formatter.date(string: "0404")).toNot(beNil())
      expect(formatter.date(string: "12")).to(beNil())
    }

    it("string from date") {
      var dateComponents = DateComponents()
      dateComponents.hour = 10
      dateComponents.minute = 11

      let date = Calendar.current.date(from: dateComponents)!

      expect(formatter.string(date: date)).to(equal("10 : 11"))
    }
  }
}
