import UIKit

class OptionsFormFieldView: FormFieldView {

  @IBOutlet private weak var valueLabel: UILabel!
  @IBOutlet private weak var iconImageView: UIImageView!

  override var field: FormFieldModel! {
    didSet {
      self.valueLabel.text = field.value as? String
    }
  }

  override func awakeFromNib() {
    super.awakeFromNib()

    self.backgroundColor = .clear

    self.valueLabel.font = FormStyle.textFont
    self.valueLabel.textColor = FormStyle.textColor
    self.valueLabel.text = nil

    self.iconImageView.image = UIImage(systemName: "chevron.right")
    self.iconImageView.tintColor = .black
  }

  override func focus() {
    self.formDelegate?.fieldDidSelect(self.field)
  }
}
