import UIKit

class EmptyStateView: UIView {

  @IBOutlet private weak var messageLabel: UILabel!
  @IBOutlet private weak var button: UnderlinedButton!

  private var action: (() -> Void)?

  override func awakeFromNib() {
    super.awakeFromNib()

    self.messageLabel.font = .big
    self.messageLabel.textColor = .textDark
  }

  // MARK: - Actions

  @IBAction func tapButton() {
    self.action?()
  }

  // MARK: - Public

  func setMessage(_ message: String?) {
    self.messageLabel.text = message
  }

  func setButton(title: String?, action: @escaping () -> Void) {
    self.button.title = title
    self.action = action
  }
}
