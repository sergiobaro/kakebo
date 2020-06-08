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
}
