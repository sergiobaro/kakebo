import Quick
import Nimble

@testable import Kakebo

class DateFactorySpec: QuickSpec {
  override func spec() {

    it("Start Date") {
      let components = DateComponents(year: 2020, month: 1)
      let date = Calendar.current.date(from: components)!

      let startDate = date.startOfMonth()

      let startDateComponents = Calendar.current.dateComponents([.day, .month, .year], from: startDate)
      expect(startDateComponents.day) == 1
      expect(startDateComponents.month) == 1
      expect(startDateComponents.year) == 2020
    }

    it("End Date") {
      let components = DateComponents(year: 2020, month: 3)
      let date = Calendar.current.date(from: components)!

      let endDate = date.endOfMonth()

      let endDateComponents = Calendar.current.dateComponents([.day, .month, .year], from: endDate)
      expect(endDateComponents.day) == 31
      expect(endDateComponents.month) == 3
      expect(endDateComponents.year) == 2020
    }

  }
}
