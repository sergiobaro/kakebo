import UIKit

protocol FormViewDelegate: class {

  func fieldDidChange(_ field: FormFieldModel)
  func formDidFinish()

}

// sourcery: AutoMockable
protocol FormFieldDelegate: class {

  func fieldDidChange(_ field: FormFieldContainerView)
  func fieldDidBeginEditing(_ field: FormFieldContainerView)
  func fieldDidEndEditing(_ field: FormFieldContainerView)

}

class FormView: UIView {

  weak var delegate: FormViewDelegate?

  private var fields = [FormFieldContainerView]()

  init(fields: [FormFieldContainerView]) {
    self.fields = fields

    super.init(frame: .zero)

    self.setup()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setup() {
    self.setupFields()
  }

  private func setupFields() {
    var previousView: FormFieldContainerView!
    
    for fieldView in self.fields {
      fieldView.formDelegate = self
      self.addSubview(fieldView)

      fieldView.snp.makeConstraints({ $0.height.equalTo(FormStyle.fieldHeight) })

      if previousView == nil { // first field
        fieldView.snp.makeConstraints({
          $0.left.right.equalToSuperview()
          $0.top.equalToSuperview().offset(FormStyle.margin)
        })
      } else {
        fieldView.snp.makeConstraints({
          $0.left.right.equalToSuperview()
          $0.top.equalTo(previousView.snp.bottom)
        })
      }

      previousView = fieldView
    }

    previousView.snp.makeConstraints({ $0.bottom.equalToSuperview() })
  }

  // MARK: - Public

  func focus() {
    self.fields.first?.focus()
  }

  func blur() {
    self.fields.first(where: { $0.isFirstResponder })?.blur()
  }

  func value(for identifier: String) -> Any? {
    let field = self.fields.first(where: { $0.field.identifier == identifier })

    return field?.field.value
  }

  func allFields() -> [FormFieldModel] {
    return self.fields.map({ $0.field })
  }

  func setReturnKeyType(_ type: UIReturnKeyType) {
    self.fields.last?.setReturnKeyType(type)
  }

  // MARK: - Private

  private func nextFieldView(field: FormFieldModel) -> FormFieldContainerView? {
    guard let index = self.fields.firstIndex(where: { $0.field == field }) else {
      return nil
    }

    return self.fields.element(at: index + 1)
  }
}

extension FormView: FormFieldDelegate {

  func fieldDidChange(_ field: FormFieldContainerView) {
    self.delegate?.fieldDidChange(field.field)
  }

  func fieldDidBeginEditing(_ field: FormFieldContainerView) {
    self.fields
      .filter({ $0 !== field })
      .forEach({ $0.blur() })
  }

  func fieldDidEndEditing(_ field: FormFieldContainerView) {
    if let nextFieldView = self.nextFieldView(field: field.field) {
      nextFieldView.focus()
    } else {
      self.delegate?.formDidFinish()
    }
  }
}
