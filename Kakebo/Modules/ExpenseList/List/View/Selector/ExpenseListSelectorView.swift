import UIKit

protocol ExpenseListSelectorViewDelegate: class {

  func expenseSelectorViewDidSelectDay(_ expenseListSelectorView: ExpenseListSelectorView)
  func expenseSelectorViewDidSelectMonth(_ expenseListSelectorView: ExpenseListSelectorView)

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

  @IBAction func tapDayButton() {
    self.monthButton.isSelected = false
    self.dayButton.isSelected = true
    self.delegate?.expenseSelectorViewDidSelectDay(self)
  }

  @IBAction func tapMonthButton() {
    self.monthButton.isSelected = true
    self.dayButton.isSelected = false
    self.delegate?.expenseSelectorViewDidSelectMonth(self)
  }

  private func setup(button: UIButton) {
    button.setTitleColor(.red, for: .selected)
//    button.setTitleColor(.green, for: .normal)
  }
}
