import Quick
import Nimble
import SwiftyMocky

@testable import Kakebo

class AmountFormFieldPresenterSpec: QuickSpec {
    override func spec() {

      var viewMock: InputFormFieldViewProtocolMock!
      var formDelegateMock: FormFieldDelegateMock!
      var field: FormFieldModel!
      var presenter: AmountFormFieldPresenter!

      beforeEach {
        viewMock = InputFormFieldViewProtocolMock()
        formDelegateMock = FormFieldDelegateMock()
        field = FormFieldModel(type: .amount, identifier: "amount", title: "Amount", value: 0 as Any)

        presenter = AmountFormFieldPresenter(view: viewMock)
        presenter.formDelegate = formDelegateMock
        presenter.field = field
      }

      it("empty state") {
        expect(presenter.hasText).to(beFalse())
        expect(presenter.value).to(beNil())
      }
      
      it("insert text") {
        presenter.userInsertText("1")

        expect(presenter.hasText).to(beTrue())

        Verify(viewMock, .updateValue("$0.01"))
        Verify(formDelegateMock, .fieldDidChange(.matching({ ($0.value as? Int) == 1 })))
      }

      it("set value") {
        presenter.value = 20 as Any

        expect(presenter.hasText).to(beTrue())

        Verify(viewMock, .updateValue("$0.20"))
        Verify(formDelegateMock, .fieldDidChange(.matching({ ($0.value as? Int) == 20 })))
      }

      it("insert text no number") {
        presenter.userInsertText("n")

        Verify(viewMock, .never, .updateValue(.any))
        Verify(formDelegateMock, .never, .fieldDidEndEditing(.any))

        expect(presenter.hasText).to(beFalse())
      }

      it("insert text new line") {
        presenter.userInsertText("\n")

        Verify(formDelegateMock, .fieldDidEndEditing(.any))
      }

      it("insert text and then another text") {
        presenter.userInsertText("1")
        presenter.userInsertText("2")

        expect(presenter.value as? Int).to(equal(12))
      }

      it("user delete backward") {
        presenter.userDeleteBackward()

        expect(presenter.value).to(beNil())
      }
      
      it("user delete backward after insert text") {
        presenter.userInsertText("1")
        presenter.userDeleteBackward()

        expect(presenter.value).to(beNil())
      }
    }
}
