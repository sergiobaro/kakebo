import UIKit
import SnapKit

class FormBuilder {

  private var fieldViews = [FormFieldView]()

  func add(field: FormField) -> FormBuilder {
    let fieldView = self.makeField(field)
    self.fieldViews.append(fieldView)

    return self
  }

  func add(to view: UIView) -> FormView {
    let formView = self.makeFormView()
    self.add(formView: formView, to: view)

    return formView
  }

}

private extension FormBuilder {

  func makeFormView() -> FormView {
    let formView = FormView(fieldViews: self.fieldViews)

    return formView
  }

  func makeField(_ field: FormField) -> FormFieldView {
    switch field.type {
    case .text:
      return self.makeTextField(field)
    }
  }

  func makeTextField(_ field: FormField) -> FormFieldView {
    let textField = UIView.loadFromNib(type: TextFormFieldView.self)
    textField.field = field
    if case let FormFieldType.text(value) = field.type {
      textField.textField.text = value
    }
    textField.titleLabel.text = field.title

    return textField
  }

  func add(formView: FormView, to view: UIView) {
    formView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(formView)
    formView.snp.makeConstraints({ $0.top.left.right.equalToSuperview() })
  }
}
