import UIKit

class CategorySelectorCell: UITableViewCell {

  @IBOutlet private weak var nameLabel: UILabel!
  @IBOutlet private weak var iconImageView: UIImageView!

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: true)

    self.iconImageView.isHidden = !selected
  }

  override func awakeFromNib() {
    super.awakeFromNib()

    self.nameLabel.text = ""
    self.iconImageView.image = UIImage(systemName: "checkmark")
    self.iconImageView.tintColor = .black
  }
}
