import Quick
import Nimble
@testable import Kakebo

class ValidatorsSpec: QuickSpec {
    override func spec() {

      it("NotEmptyValidator") {
        let validator = NotEmptyValidator()

        expect(validator.isValid(nil)).to(beFalse())
        expect(validator.isValid("" as Any)).to(beFalse())
        expect(validator.isValid("a" as Any)).to(beTrue())
        expect(validator.isValid(0 as Any)).to(beTrue())
      }

      it("NotNilValidator") {
        let validator = NotNilValidator()

        expect(validator.isValid(nil)).to(beFalse())
        expect(validator.isValid("" as Any)).to(beTrue())
        expect(validator.isValid(0 as Any)).to(beTrue())
      }
    }
}
