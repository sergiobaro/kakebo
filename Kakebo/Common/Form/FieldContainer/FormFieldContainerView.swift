import UIKit
import SnapKit

class FormFieldContainerView: UIView {

  weak var formDelegate: FormFieldDelegate? {
    didSet {
      self.fieldView.formDelegate = self.formDelegate
    }
  }
  weak var formController: FormController? {
    didSet {
      self.fieldView.formController = self.formController
    }
  }

  var field: FormFieldModel! {
    didSet {
      self.titleLabel.text = field.title
    }
  }

  @IBOutlet private weak var titleLabel: UILabel!
  @IBOutlet private weak var fieldContainerView: UIView!

  private weak var fieldView: FormFieldView! {
    didSet {
      self.fieldView.formDelegate = self.formDelegate
      self.fieldView.formController = self.formController
    }
  }

  override func awakeFromNib() {
    super.awakeFromNib()

    self.backgroundColor = .clear

    self.titleLabel.font = FormStyle.titleFont
    self.titleLabel.textColor = FormStyle.titleTextColor
    self.titleLabel.text = ""

    self.fieldContainerView.backgroundColor = .clear
    
    self.fieldContainerView.layer.cornerRadius = 2.0
    self.setInactiveStyle()
  }

  // MARK: - Actions

  @IBAction func tapView() {
    self.becomeFirstResponder()
    self.formDelegate?.fieldDidBeginEditing(self.field)
    self.focus()
  }

  // MARK: - Public

  func setFieldView(_ fieldView: FormFieldView) {
    self.fieldView = fieldView
    fieldView.field = self.field

    self.fieldContainerView.addSubview(fieldView)
    fieldView.snp.makeConstraints({ $0.edges.equalToSuperview().inset(FormStyle.margin) })
  }

  func focus() {
    if self.isValid() {
      self.setActiveStyle()
    }
    self.fieldView.focus()
  }

  func blur() {
    if self.isValid() {
      self.setInactiveStyle()
    }
    self.fieldView.blur()
  }
  
  func setReturnKeyType(_ type: UIReturnKeyType) {
    self.fieldView.setReturnKeyType(type)
  }

  // MARK: - Private

  private func setActiveStyle() {
    self.updateBorder(color: FormStyle.borderActiveColor, width: FormStyle.borderActiveWidth)
  }

  private func setInactiveStyle() {
    self.updateBorder(color: FormStyle.borderInactiveColor, width: FormStyle.borderInactiveWidth)
  }

  private func setErrorStyle() {
    self.updateBorder(color: FormStyle.borderErrorColor, width: FormStyle.borderActiveWidth)
  }

  private func updateBorder(color: UIColor, width: CGFloat) {
    self.fieldContainerView.layer.borderWidth = width
    self.fieldContainerView.layer.borderColor = color.cgColor
  }

  private func isValid() -> Bool {
    return self.field.validators.allSatisfy { $0.isValid(self.field.value) }
  }
}

extension FormFieldContainerView: FormFieldDelegate {

  func fieldDidChange(_ field: FormFieldModel) {
    self.field = field
    self.formDelegate?.fieldDidChange(field)

    if self.isValid() {
      self.setActiveStyle()
    } else {
      self.setErrorStyle()
    }
  }

  func fieldDidBeginEditing(_ field: FormFieldModel) {
    self.setActiveStyle()
    self.formDelegate?.fieldDidBeginEditing(field)
  }

  func fieldDidEndEditing(_ field: FormFieldModel) {
    self.setInactiveStyle()
    self.formDelegate?.fieldDidEndEditing(field)
  }
}
