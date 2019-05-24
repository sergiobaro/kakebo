import UIKit
import SnapKit

protocol FormFieldContainer: class {

  func fieldDidBecomeFirstResponder()
  func fieldDidResignFirstResponder()

}

class FormFieldContainerView: UIView {

  weak var formDelegate: FormFieldDelegate?

  var field: FormFieldModel! {
    didSet {
      self.titleLabel.text = field.title
    }
  }

  @IBOutlet private weak var titleLabel: UILabel!
  @IBOutlet private weak var fieldContainerView: UIView!

  private weak var fieldView: FormFieldView!

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

  // MARK: - Public

  func setFieldView(_ fieldView: FormFieldView) {
    self.fieldView = fieldView
    fieldView.container = self

    self.fieldContainerView.addSubview(fieldView)
    fieldView.snp.makeConstraints({ $0.edges.equalToSuperview().inset(FormStyle.margin) })
  }

  func focus() {
    self.setActiveStyle()
    self.fieldView.focus()
  }

  func blur() {
    self.setInactiveStyle()
    self.fieldView.blur()
  }
  
  func setReturnKeyType(_ type: UIReturnKeyType) {
    self.fieldView.setReturnKeyType(type)
  }

  // MARK: - Private

  private func setActiveStyle() {
    self.fieldContainerView.layer.borderWidth = FormStyle.borderActiveWidth
    self.fieldContainerView.layer.borderColor = FormStyle.borderActiveColor.cgColor
  }

  private func setInactiveStyle() {
    self.fieldContainerView.layer.borderWidth = FormStyle.borderInactiveWidth
    self.fieldContainerView.layer.borderColor = FormStyle.borderInactiveColor.cgColor
  }
}

extension FormFieldContainerView: FormFieldContainer {

  func fieldDidBecomeFirstResponder() {
    self.setActiveStyle()
    self.formDelegate?.fieldDidBeginEditing(self)
  }

  func fieldDidResignFirstResponder() {
    self.setInactiveStyle()
    self.formDelegate?.fieldDidEndEditing(self)
  }
}
