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
    case .date:
      return self.makeDateField(field)
    }
  }

  func makeTextField(_ field: FormFieldModel) -> FormField {
    let textField = UIView.loadFromNib(type: TextFormFieldView.self)
    textField.field = field
    textField.value = field.value
    textField.title = field.title

    return textField
  }

  func makeAmountField(_ field: FormFieldModel) -> FormField {
    let amountField = UIView.loadFromNib(type: InputFormFieldView.self)
    amountField.presenter = AmountFormFieldPresenter(view: amountField)

    amountField.field = field
    amountField.value = field.value
    amountField.title = field.title
    
    return amountField
  }

  func makeDateField(_ field: FormFieldModel) -> FormField {
    let dateField = UIView.loadFromNib(type: InputFormFieldView.self)
    dateField.presenter = DateFormFieldPresenter(view: dateField)

    dateField.field = field
    dateField.value = field.value
    dateField.title = field.title

    return dateField
  }
}
