import UIKit

protocol FormViewDelegate: class {

  func fieldDidChange(_ field: FormField)
  func formDidFinish()

}

class FormView: UIView {

  weak var delegate: FormViewDelegate?

  private var fieldViews = [FormFieldView]()

  init(fieldViews: [FormFieldView]) {
    self.fieldViews = fieldViews

    super.init(frame: .zero)

    self.setup()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setup() {
    self.setupFields()
    self.setReturnKeyType(.done)
  }

  private func setupFields() {
    let verticalOffset: CGFloat = 10.0
    var previousView: UIView!
    
    for fieldView in self.fieldViews {
      fieldView.formDelegate = self
      self.addSubview(fieldView)

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

      let separator = FormFieldSeparator.make()
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
    return self.fieldViews.first?.becomeFirstResponder() ?? false
  }

  @discardableResult
  override func resignFirstResponder() -> Bool {
    return self.fieldViews.first(where: { $0.isFirstResponder })?.resignFirstResponder() ?? false
  }

  func value(for identifier: String) -> Any? {
    guard let field = self.fieldViews.first(where: { $0.field.identifier == identifier }) else {
      return nil
    }

    return field.value
  }

  func setReturnKeyType(_ type: UIReturnKeyType) {
    self.fieldViews.last?.setReturnKeyType(type)
  }

  // MARK: - Private

  private func nextFieldView(field: FormField) -> FormFieldView? {
    guard let index = self.fieldViews.firstIndex(where: { $0.field == field }) else {
      return nil
    }

    return self.fieldViews.element(at: index + 1)
  }
}

extension FormView: FieldFormDelegate {

  func fieldDidChange(_ field: FormField) {
    self.delegate?.fieldDidChange(field)
  }

  func fieldDidEndEditing(_ field: FormField) {
    if let nextFieldView = self.nextFieldView(field: field) {
      nextFieldView.becomeFirstResponder()
    } else {
      self.fieldViews.last?.resignFirstResponder()
      self.delegate?.formDidFinish()
    }
  }

}
