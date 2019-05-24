import Quick
import Nimble
import SwiftyMocky

@testable import Kakebo

class FormFieldDelegateMock: FormFieldDelegate {

  var fieldCalled: FormFieldModel?

  var fieldDidChangeCalled = false
  func fieldDidChange(_ field: FormFieldModel) {
    self.fieldDidChangeCalled = true
    self.fieldCalled = field
  }

  var fieldDidEndEditingCalled = false
  func fieldDidEndEditing(_ field: FormFieldModel) {
    self.fieldDidEndEditingCalled = true
    self.fieldCalled = field
  }
}

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

        expect(formDelegateMock.fieldDidChangeCalled).to(beTrue())
        expect(formDelegateMock.fieldCalled?.value as? Int).to(equal(1))
      }

      it("set value") {
        presenter.value = 20 as Any

        expect(presenter.hasText).to(beTrue())

//        expect(viewMock.updateValueCalled).to(beTrue())
//        expect(viewMock.valueCalled).to(equal("$0.20"))

        expect(formDelegateMock.fieldDidChangeCalled).to(beTrue())
        expect(formDelegateMock.fieldCalled?.value as? Int).to(equal(20))
      }

      it("insert text no number") {
        presenter.userInsertText("n")

        expect(presenter.hasText).to(beFalse())
//        expect(viewMock.updateValueCalled).to(beFalse())
        expect(formDelegateMock.fieldDidChangeCalled).to(beFalse())
      }

      it("insert text new line") {
        presenter.userInsertText("\n")

        expect(formDelegateMock.fieldDidEndEditingCalled).to(beTrue())
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
