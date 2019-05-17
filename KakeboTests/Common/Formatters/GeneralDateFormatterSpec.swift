import Quick
import Nimble

@testable import Kakebo

class GeneralDateFormatterSpec: QuickSpec {
  override func spec() {

    context("time") {

      var timeFormatter: GeneralDateFormatter!

      beforeEach {
        timeFormatter = GeneralDateFormatter(fields: ["HH", "mm"], separator: " : ")
      }

      it("string from string") {
        expect(timeFormatter.string(string: nil)).to(equal(""))
        expect(timeFormatter.string(string: "")).to(equal(""))

        expect(timeFormatter.string(string: "0")).to(equal("0"))
        expect(timeFormatter.string(string: "1")).to(equal("1"))

        expect(timeFormatter.string(string: "01")).to(equal("01 : "))
        expect(timeFormatter.string(string: "10")).to(equal("10 : "))
        expect(timeFormatter.string(string: "123")).to(equal("12 : 3"))
        expect(timeFormatter.string(string: "1230")).to(equal("12 : 30"))

        expect(timeFormatter.string(string: "123020")).to(equal("12 : 30"))
      }

      it("trim string") {
        expect(timeFormatter.trim(string: "")).to(equal(""))

        expect(timeFormatter.trim(string: "123456")).to(equal("1234"))

        expect(timeFormatter.trim(string: "123456789")).to(equal("1234"))
      }

      it("date from string") {
        expect(timeFormatter.date(string: "0404")).toNot(beNil())
        expect(timeFormatter.date(string: "12")).to(beNil())
      }

      it("string from date") {
        var dateComponents = DateComponents()
        dateComponents.hour = 10
        dateComponents.minute = 11

        let date = Calendar.current.date(from: dateComponents)!

        expect(timeFormatter.string(date: date)).to(equal("10 : 11"))
      }
    }

    context("date") {

      var dateFormatter: GeneralDateFormatter!

      beforeEach {
        dateFormatter = GeneralDateFormatter(fields: ["dd", "MM", "yyyy"], separator: " / ")
      }

      it("string from string") {
        expect(dateFormatter.string(string: "")).to(equal(""))

        expect(dateFormatter.string(string: "0")).to(equal("0"))
        expect(dateFormatter.string(string: "1")).to(equal("1"))

        expect(dateFormatter.string(string: "01")).to(equal("01 / "))
        expect(dateFormatter.string(string: "10")).to(equal("10 / "))
        expect(dateFormatter.string(string: "123")).to(equal("12 / 3"))
        expect(dateFormatter.string(string: "1230")).to(equal("12 / 30 / "))

        expect(dateFormatter.string(string: "123020")).to(equal("12 / 30 / 20"))
        expect(dateFormatter.string(string: "12302019")).to(equal("12 / 30 / 2019"))

        expect(dateFormatter.string(string: "12302019000")).to(equal("12 / 30 / 2019"))
      }

      it("trim string") {
        expect(dateFormatter.trim(string: "")).to(equal(""))

        expect(dateFormatter.trim(string: "123456")).to(equal("123456"))

        expect(dateFormatter.trim(string: "123456789")).to(equal("12345678"))
      }

      it("date from string") {
        expect(dateFormatter.date(string: "04042019")).toNot(beNil())
        expect(dateFormatter.date(string: "12")).to(beNil())
      }

      it("string from date") {
        let date = Date(timeIntervalSince1970: 0)

        expect(dateFormatter.string(date: date)).to(equal("01 / 01 / 1970"))
      }
    }

  }
}
