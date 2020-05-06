import UIKit

class ExpenseListCell: UITableViewCell {
  
  static let height: CGFloat = 80.0
  
  @IBOutlet private weak var nameLabel: UILabel!
  @IBOutlet private weak var amountLabel: UILabel!
  @IBOutlet private weak var categoriesLabel: UILabel!
  @IBOutlet private weak var dateLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()

    self.backgroundColor = .clear
    self.selectedBackgroundView = UIView()
    self.selectedBackgroundView?.backgroundColor = .selected

    self.nameLabel.textColor = .textDark
    self.nameLabel.font = .big
    self.nameLabel.text = ""

    self.amountLabel.textColor = .textDark
    self.amountLabel.font = .big
    self.amountLabel.text = ""

    self.categoriesLabel.textColor = .textDark
    self.categoriesLabel.font = .small
    self.categoriesLabel.text = ""

    self.dateLabel.textColor = .textDark
    self.dateLabel.font = .small
    self.dateLabel.text = ""
  }

  func fill(with expense: ExpenseListViewModel) {
    nameLabel.text = expense.name
    amountLabel.text = expense.amount
    dateLabel.text = expense.date
    categoriesLabel.text = expense.categories
  }
  
}
