import Quick
import Nimble
@testable import Kakebo

class FormFieldModelSpec: QuickSpec {
    override func spec() {

      describe("equatable") {
        context("have different identifiers") {
          it("should not be equal") {
            let text1 = FormFieldModel(type: .text, identifier: "text1", title: nil, validators: [], value: nil)
            let text2 = FormFieldModel(type: .text, identifier: "text2", title: nil, validators: [], value: nil)

            expect(text1).toNot(equal(text2))
          }
        }

        context("have same identiifer") {
          it("should be equal") {
            let text1 = FormFieldModel(type: .text, identifier: "text", title: nil, validators: [], value: nil)
            let text2 = FormFieldModel(type: .text, identifier: "text", title: nil, validators: [], value: nil)

            expect(text1).to(equal(text2))
          }
        }
      }
    }
}
