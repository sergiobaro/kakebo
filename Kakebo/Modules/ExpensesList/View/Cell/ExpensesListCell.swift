import UIKit

class ExpensesListCell: UITableViewCell {
  
  static let height: CGFloat = 80.0
  
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var amountLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    self.nameLabel.font = UIFont.systemFont(ofSize: 20.0)
    
    self.amountLabel.font = UIFont.systemFont(ofSize: 20.0)
    
    self.dateLabel.font = UIFont.systemFont(ofSize: 14.0)
    self.dateLabel.textColor = .darkGray
  }
  
}
