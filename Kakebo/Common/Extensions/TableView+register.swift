import UIKit

extension UITableView {
  
  func register<Cell: UITableViewCell>(_ type: Cell.Type) {
    let identifier = String(describing: Cell.self)
    let nib = UINib(nibName: identifier, bundle: nil)
    self.register(nib, forCellReuseIdentifier: identifier)
  }
  
  func dequeue<Cell: UITableViewCell>(_ type: Cell.Type, for indexPath: IndexPath) -> Cell? {
    let identifier = String(describing: Cell.self)
    
    return self.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? Cell
  }
}
