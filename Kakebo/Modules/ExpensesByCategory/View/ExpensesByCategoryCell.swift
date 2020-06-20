import UIKit

class ExpensesByCategoryCell: UITableViewCell {

  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var amountLabel: UILabel!

  override func awakeFromNib() {
    super.awakeFromNib()

    self.nameLabel.text = ""
    self.nameLabel.font = UIFont.big

    self.amountLabel.text = ""
    self.amountLabel.font = UIFont.mediumBold
  }

  func showViewModel(_ viewModel: ExpensesByCategoryViewModel) {
    self.nameLabel.text = viewModel.categoryName
    self.amountLabel.text = viewModel.amount
    self.amountLabel.font = viewModel.amountBold ? UIFont.mediumBold : UIFont.medium
  }
}
