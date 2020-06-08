import UIKit

class CategorySelectorCell: UITableViewCell {

  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet private weak var iconImageView: UIImageView!

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: true)

    self.iconImageView.isHidden = !selected
  }

  override func awakeFromNib() {
    super.awakeFromNib()

    self.nameLabel.text = ""
    self.nameLabel.font = UIFont.big
    self.iconImageView.image = UIImage(systemName: "checkmark")
    self.iconImageView.tintColor = .black
  }
}
