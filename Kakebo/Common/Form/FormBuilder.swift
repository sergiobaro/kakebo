import UIKit
import SnapKit

class FormBuilder {

  private var fields = [FormFieldContainerView]()

  @discardableResult
  func add(field: FormFieldModel) -> Self {
    let fieldView = self.makeField(field)
    self.fields.append(fieldView)

    return self
  }

  @discardableResult
  func add(fields: [FormFieldModel]) -> Self {
    fields.forEach({ self.add(field: $0) })

    return self
  }

  func add(to view: UIView) -> FormView {
    let formView = self.makeFormView()

    view.addSubview(formView)
    formView.snp.makeConstraints({ $0.top.left.right.equalToSuperview() })

    return formView
  }
}

private extension FormBuilder {

  func makeFormView() -> FormView {
    let formView = FormView(fields: self.fields)

    return formView
  }

  func makeField(_ field: FormFieldModel) -> FormFieldContainerView {
    switch field.type {
    case .text:
      return self.makeTextField(field)
    case .amount:
      return self.makeAmountField(field)
    case .date:
      return self.makeDateField(field)
    case .time:
      return self.makeTimeField(field)
    }
  }

  func makeTextField(_ field: FormFieldModel) -> FormFieldContainerView {
    let fieldContainer = UIView.loadFromNib(type: FormFieldContainerView.self)
    fieldContainer.field = field

    let textField = self.makeTextFieldView()
    fieldContainer.setFieldView(textField)

    return fieldContainer
  }

  func makeAmountField(_ field: FormFieldModel) -> FormFieldContainerView {
    let fieldContainer = UIView.loadFromNib(type: FormFieldContainerView.self)
    fieldContainer.field = field

    let inputField = self.makeInputFieldView()
    inputField.presenter = AmountFormFieldPresenter(view: inputField)
    fieldContainer.setFieldView(inputField)

    return fieldContainer
  }

  func makeDateField(_ field: FormFieldModel) -> FormFieldContainerView {
    let fieldContainer = UIView.loadFromNib(type: FormFieldContainerView.self)
    fieldContainer.field = field

    let inputField = self.makeInputFieldView()
    inputField.presenter = DateFormFieldPresenter(
      view: inputField,
      formatter: GeneralDateFormatter(fields: ["dd", "MM", "yyyy"], separator: " / ")
    )
    fieldContainer.setFieldView(inputField)

    return fieldContainer
  }

  func makeTimeField(_ field: FormFieldModel) -> FormFieldContainerView {
    let fieldContainer = UIView.loadFromNib(type: FormFieldContainerView.self)
    fieldContainer.field = field

    let inputField = self.makeInputFieldView()
    inputField.presenter = DateFormFieldPresenter(
      view: inputField,
      formatter: GeneralDateFormatter(fields: ["HH", "mm"], separator: " : ")
    )
    fieldContainer.setFieldView(inputField)

    return fieldContainer
  }

  func makeTextFieldView() -> TextFormFieldView {
    return UIView.loadFromNib(type: TextFormFieldView.self)
  }

  func makeInputFieldView() -> InputFormFieldView {
    return UIView.loadFromNib(type: InputFormFieldView.self)
  }
}
