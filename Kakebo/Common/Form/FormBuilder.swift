import UIKit
import SnapKit

class FormBuilder {

  private var fields = [FormField]()

  func add(field: FormFieldModel) -> FormBuilder {
    let fieldView = self.makeField(field)
    self.fields.append(fieldView)

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

  func makeField(_ field: FormFieldModel) -> FormField {
    switch field.type {
    case .text:
      return self.makeTextField(field)
    case .amount:
      return self.makeAmountField(field)
    }
  }

  func makeTextField(_ field: FormFieldModel) -> FormField {
    let textField = UIView.loadFromNib(type: TextFormFieldView.self)
    textField.field = field
    
    if case let FormFieldType.text(value) = field.type {
      textField.value = value
    }
    textField.title = field.title

    return textField
  }

  func makeAmountField(_ field: FormFieldModel) -> FormField {
    let amountField = UIView.loadFromNib(type: AmountFormFieldView.self)
    amountField.field = field

    if case let FormFieldType.amount(value) = field.type {
      amountField.value = value
    }
    amountField.title = field.title

    return amountField
  }

}
