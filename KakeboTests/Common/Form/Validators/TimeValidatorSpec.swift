import Quick
import Nimble
@testable import Kakebo

class TimeValidatorSpec: QuickSpec {
    override func spec() {

      it("NotEmptyValidator") {
        let validator = TimeValidator()
        
        expect(validator.isValid(nil)).to(beFalse())
        expect(validator.isValid(1 as Any)).to(beFalse())
        expect(validator.isValid("" as Any)).to(beFalse())
        expect(validator.isValid("0:00" as Any)).to(beFalse())
        expect(validator.isValid("0:0" as Any)).to(beFalse())
        
        expect(validator.isValid("00:01" as Any)).to(beTrue())
        expect(validator.isValid("12:59" as Any)).to(beTrue())
        
        expect(validator.isValid("00:60" as Any)).to(beFalse())
        expect(validator.isValid("24:01" as Any)).to(beFalse())
        expect(validator.isValid("25:00" as Any)).to(beFalse())
      }
    }
}
