import UIKit

enum ExpenseListSelectorViewType: String {
  case day
  case month
}

protocol ExpenseListSelectorViewDelegate: AnyObject {

  func expenseListSelectorViewDidSelect(type: ExpenseListSelectorViewType)
}

class ExpenseListSelectorView: UIView {

  weak var delegate: ExpenseListSelectorViewDelegate?

  @IBOutlet private weak var dayButton: UIButton!
  @IBOutlet private weak var monthButton: UIButton!

  override func awakeFromNib() {
    super.awakeFromNib()

    self.setup(button: self.monthButton)
    self.setup(button: self.dayButton)

    self.monthButton.setTitle(localize("Month"), for: .normal)
    self.monthButton.addTarget(self, action: #selector(tapMonthButton), for: .touchUpInside)

    self.dayButton.setTitle(localize("Day"), for: .normal)
    self.dayButton.addTarget(self, action: #selector(tapDayButton), for: .touchUpInside)

    self.dayButton.isSelected = true
  }

  @objc func tapDayButton() {
    self.monthButton.isSelected = false
    self.dayButton.isSelected = true
    self.delegate?.expenseListSelectorViewDidSelect(type: .day)
  }

  @objc func tapMonthButton() {
    self.monthButton.isSelected = true
    self.dayButton.isSelected = false
    self.delegate?.expenseListSelectorViewDidSelect(type: .month)
  }

  private func setup(button: UIButton) {
    guard let title = button.title(for: .normal) else {
      return
    }

    // normal
    let titleNormal = NSAttributedString(string: title, attributes: [.font: UIFont.medium])
    button.setAttributedTitle(titleNormal, for: .normal)

    // selected
    let titleSelected = NSAttributedString(string: title, attributes: [.font: UIFont.mediumBold])
    button.setAttributedTitle(titleSelected, for: .selected)
  }
}
