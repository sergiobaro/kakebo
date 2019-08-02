import UIKit

class ExpenseListCell: UITableViewCell {
  
  static let height: CGFloat = 80.0
  
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var amountLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()

    self.backgroundColor = .clear
    self.selectedBackgroundView = UIView()
    self.selectedBackgroundView?.backgroundColor = .selected

    self.nameLabel.textColor = .textDark
    self.nameLabel.font = .big

    self.amountLabel.textColor = .textDark
    self.amountLabel.font = .big
    
    self.dateLabel.font = .small
    self.dateLabel.textColor = .textDark
  }
  
}
