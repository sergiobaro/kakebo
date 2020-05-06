import UIKit

class CalendarFormFieldView: FormFieldView {
  
  @IBOutlet private weak var label: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()

    self.backgroundColor = .clear

    self.label.font = FormStyle.textFont
    self.label.textColor = FormStyle.textColor
    self.label.text = nil
  }
  
  override func focus() {
    let keyboardView = UIView.loadFromNib(type: CalendarFormFieldKeyboardView.self)
    keyboardView.snp.makeConstraints {
      $0.height.equalTo(FormStyle.customKeyboardHeight)
    }
    self.formController?.showCustomKeyboard(keyboardView)
  }
}
