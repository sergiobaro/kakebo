import UIKit

// sourcery: AutoMockable
protocol FormViewDelegate: class {

  func formFieldDidChange(_ field: FormFieldModel)
  func formDidFinish(with fields: [FormFieldModel])

}

// sourcery: AutoMockable
protocol FormFieldDelegate: class {

  func fieldDidChange(_ field: FormFieldModel)
  func fieldDidBeginEditing(_ field: FormFieldModel)
  func fieldDidEndEditing(_ field: FormFieldModel)

}

class FormView: UIView {

  weak var delegate: FormViewDelegate?

  private var fields = [FormFieldContainerView]()
  private var editing = false

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
    var previousFieldView: FormFieldContainerView!
    
    for fieldView in self.fields {
      fieldView.formDelegate = self
      self.addSubview(fieldView)

      fieldView.snp.makeConstraints({ $0.height.equalTo(FormStyle.fieldHeight) })

      if previousFieldView == nil { // first field
        fieldView.snp.makeConstraints({
          $0.left.right.equalToSuperview()
          $0.top.equalToSuperview().offset(FormStyle.margin)
        })
      } else {
        fieldView.snp.makeConstraints({
          $0.left.right.equalToSuperview()
          $0.top.equalTo(previousFieldView.snp.bottom)
        })
      }

      previousFieldView = fieldView
      fieldView.setReturnKeyType(.next)
    }

    previousFieldView.setReturnKeyType(.done)
    previousFieldView.snp.makeConstraints({ $0.bottom.equalToSuperview() })
  }

  // MARK: - Public

  func focus() {
    self.editing = true
    self.fields.first?.focus()
  }

  func blur() {
    self.editing = false
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

  private func currentFieldView(field: FormFieldModel) -> FormFieldContainerView? {
    return self.fields.first(where: { $0.field == field })
  }
}

extension FormView: FormFieldDelegate {

  func fieldDidChange(_ field: FormFieldModel) {
    self.delegate?.formFieldDidChange(field)
  }

  func fieldDidBeginEditing(_ field: FormFieldModel) {
    self.fields
      .filter({ $0.field != field })
      .forEach({ $0.blur() })
  }

  func fieldDidEndEditing(_ field: FormFieldModel) {
    guard self.editing else {
      return
    }
    
    if let nextFieldView = self.nextFieldView(field: field) {
      nextFieldView.focus()
    } else {
      self.currentFieldView(field: field)?.blur()
      self.delegate?.formDidFinish(with: self.allFields())
    }
  }
}
