import UIKit

protocol FormViewDelegate: class {

  func fieldDidChange(_ field: FormFieldModel)
  func formDidFinish()

}

class FormView: UIView {

  weak var delegate: FormViewDelegate?

  private var fields = [FormField]()

  init(fields: [FormField]) {
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
    let verticalOffset = FormStyle.fieldVerticalPadding
    var previousView: UIView!
    
    for fieldView in self.fields {
      fieldView.formDelegate = self
      self.addSubview(fieldView)

      fieldView.snp.makeConstraints({ $0.height.equalTo(FormStyle.fieldHeight) })

      if previousView == nil { // first field
        fieldView.snp.makeConstraints({
          $0.left.right.equalToSuperview()
          $0.top.equalToSuperview().offset(verticalOffset)
        })
      } else {
        fieldView.snp.makeConstraints({
          $0.left.right.equalToSuperview()
          $0.top.equalTo(previousView.snp.bottom).offset(verticalOffset)
        })
      }

      let separator = FormFieldSeparatorView.make()
      self.addSubview(separator)
      separator.snp.makeConstraints({
        $0.left.right.equalToSuperview()
        $0.top.equalTo(fieldView.snp.bottom).offset(verticalOffset)
      })

      previousView = separator
    }

    previousView.snp.makeConstraints({
      $0.bottom.equalToSuperview().inset(verticalOffset)
    })
  }

  // MARK: - Public

  @discardableResult
  override func becomeFirstResponder() -> Bool {
    return self.fields.first?.becomeFirstResponder() ?? false
  }

  @discardableResult
  override func resignFirstResponder() -> Bool {
    return self.fields.first(where: { $0.isFirstResponder })?.resignFirstResponder() ?? false
  }

  func value(for identifier: String) -> Any? {
    let field = self.fields.first(where: { $0.field.identifier == identifier })

    return field?.value
  }

  func setReturnKeyType(_ type: UIReturnKeyType) {
    self.fields.last?.setReturnKeyType(type)
  }

  // MARK: - Private

  private func nextFieldView(field: FormFieldModel) -> FormFieldView? {
    guard let index = self.fields.firstIndex(where: { $0.field == field }) else {
      return nil
    }

    return self.fields.element(at: index + 1)
  }
}

extension FormView: FormFieldDelegate {

  func fieldDidChange(_ field: FormFieldModel) {
    self.delegate?.fieldDidChange(field)
  }

  func fieldDidEndEditing(_ field: FormFieldModel) {
    if let nextFieldView = self.nextFieldView(field: field) {
      nextFieldView.becomeFirstResponder()
    } else {
      self.fields.last?.resignFirstResponder()
      self.delegate?.formDidFinish()
    }
  }
}
