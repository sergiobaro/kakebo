import UIKit

class ExpensesListSectionView: UIView {
  
  static let height: CGFloat = 30.0
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var amountLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    self.backgroundColor = .backgroundDark

    self.titleLabel.textColor = .textLight
    self.titleLabel.font = .medium

    self.amountLabel.textColor = .textLight
    self.amountLabel.font = .medium
  }

}
