import UIKit

class ExpensesListSectionView: UIView {
  
  static let height: CGFloat = 50.0
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var amountLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    self.backgroundColor = .headerBackground
  }

}
