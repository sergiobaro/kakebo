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
        field = FormFieldModel(type: .amount, identifier: "amount", title: "Amount", validators: [], value: 0 as Any)

        presenter = AmountFormFieldPresenter(view: viewMock, formDelegate: formDelegateMock, field: field)
      }

      it("empty state") {
        expect(presenter.hasText).to(beTrue())

        Verify(viewMock, .updateText("$0.00"))
      }
      
      it("insert text") {
        presenter.userInsertText("1")

        expect(presenter.hasText).to(beTrue())

        Verify(viewMock, .updateText("$0.01"))
        Verify(formDelegateMock, .fieldDidChange(.matching({ ($0.value as? Int) == 1 })))
      }

      it("insert text no number") {
        presenter.userInsertText("n")

        Verify(viewMock, 1, .updateText(.any))
        Verify(formDelegateMock, .never, .fieldDidEndEditing(.any))
      }

      it("insert text new line") {
        presenter.userInsertText("\n")

        Verify(formDelegateMock, .fieldDidEndEditing(.any))
      }

      it("insert text and then another text") {
        presenter.userInsertText("1")
        presenter.userInsertText("2")

        Verify(formDelegateMock, .fieldDidChange(.matching({ ($0.value as? Int) == 12 })))
      }

      it("user delete backward") {
        presenter.userDeleteBackward()

        Verify(viewMock, .updateText("$0.00"))
        Verify(formDelegateMock, .fieldDidChange(.matching({ ($0.value as? Int) == 0 })))
      }
      
      it("user delete backward after insert text") {
        presenter.userInsertText("1")
        presenter.userDeleteBackward()

        Verify(viewMock, .updateText("$0.00"))
        Verify(formDelegateMock, .fieldDidChange(.matching({ ($0.value as? Int) == 0 })))
      }
    }
}
