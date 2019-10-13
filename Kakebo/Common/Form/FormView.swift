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

// sourcery: AutoMockable
protocol FormController: class {
  
  func showCustomKeyboard(_ keyboardView: UIView)
  
}

class FormView: UIView {

  weak var delegate: FormViewDelegate?
  
  private var fields = [FormFieldContainerView]()
  private var editing = false
  private weak var customKeyboardContainer: UIView!

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
      fieldView.formController = self
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

  private func setupCustomKeyboardContainer() {
    guard let superview = self.superview else {
      return
    }
    
    let keyboardContainer = UIView()
    keyboardContainer.backgroundColor = FormStyle.customKeyboardBackgroundColor
    self.customKeyboardContainer = keyboardContainer
    superview.addSubview(keyboardContainer)
    
    keyboardContainer.snp.makeConstraints {
      $0.left.right.bottom.equalToSuperview()
    }
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
  
  private func hideCustomKeyboard() {
    UIView.animate(withDuration: FormStyle.customKeyboardAnimationDuration) {
      self.customKeyboardContainer.snp.updateConstraints {
        $0.bottom.equalToSuperview().offset(FormStyle.customKeyboardHeight)
      }
      self.customKeyboardContainer.superview?.layoutIfNeeded()
    }
  }
  
  // MARK: - UIView
  
  override func didMoveToSuperview() {
    super.didMoveToSuperview()
    
    self.setupCustomKeyboardContainer()
  }
}

extension FormView: FormFieldDelegate {

  func fieldDidChange(_ field: FormFieldModel) {
    self.delegate?.formFieldDidChange(field)
  }

  func fieldDidBeginEditing(_ field: FormFieldModel) {
    self.hideCustomKeyboard()
    
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

extension FormView: FormController {
  
  func showCustomKeyboard(_ keyboardView: UIView) {
    self.customKeyboardContainer.subviews.first?.removeFromSuperview()
    self.customKeyboardContainer.addSubview(keyboardView)
    
    keyboardView.snp.makeConstraints {
      $0.left.right.bottom.top.equalToSuperview()
    }
    self.customKeyboardContainer.snp.updateConstraints {
      $0.bottom.equalToSuperview().offset(FormStyle.customKeyboardHeight)
    }
    self.customKeyboardContainer.superview?.layoutIfNeeded()
    
    UIView.animate(withDuration: FormStyle.customKeyboardAnimationDuration) {
      self.customKeyboardContainer.snp.updateConstraints {
        $0.bottom.equalToSuperview()
      }
      self.customKeyboardContainer.superview?.layoutIfNeeded()
    }
  }
}
