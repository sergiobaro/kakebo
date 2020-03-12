import Quick
import Nimble
import SwiftyMocky
@testable import Kakebo

class TimeFormFieldPresenterSpec: QuickSpec {
    override func spec() {

      var viewMock: InputFormFieldViewProtocolMock!
      var formDelegateMock: FormFieldDelegateMock!
      var field: FormFieldModel!
      var presenter: TimeFormFieldPresenter!

      beforeEach {
        viewMock = InputFormFieldViewProtocolMock()
        formDelegateMock = FormFieldDelegateMock()
        field = FormFieldModel(type: .time, identifier: "time", title: "Time", validators: [], value: nil)

        presenter = TimeFormFieldPresenter(
          view: viewMock,
          formDelegate: formDelegateMock,
          field: field,
          formatter: TimeFormatter()
        )
      }

      it("empty state") {
        expect(presenter.hasText).to(beFalse())

        Verify(viewMock, .updateText("00:00"))
      }
      
      it("insert text") {
        presenter.userInsertText("1")

        expect(presenter.hasText).to(beTrue())

        Verify(viewMock, .updateText("00:01"))
        Verify(formDelegateMock, .fieldDidChange(.matching({ ($0.value as? String) == "00:01" })))
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

      it("user delete backward") {
        presenter.userDeleteBackward()

        Verify(viewMock, .updateText("00:00"))
        Verify(formDelegateMock, .fieldDidChange(.matching({ ($0.value as? String) == "00:00" })))
      }

      it("user delete backward after insert text") {
        presenter.userInsertText("1")
        presenter.userDeleteBackward()

        Verify(viewMock, .updateText("00:00"))
      }
    }
}
