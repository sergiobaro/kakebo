import UIKit

class TextField: UITextField {
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    self.layer.borderColor = UIColor.lightGray.cgColor
    self.layer.borderWidth = 1.0
    self.layer.cornerRadius = 2.0
  }
  
  override func becomeFirstResponder() -> Bool {
    self.layer.borderColor = UIColor.darkGray.cgColor
    
    return super.becomeFirstResponder()
  }
  
  override func resignFirstResponder() -> Bool {
    self.layer.borderColor = UIColor.lightGray.cgColor
    
    return super.resignFirstResponder()
  }
}
