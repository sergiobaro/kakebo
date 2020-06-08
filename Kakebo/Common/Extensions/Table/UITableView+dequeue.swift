import UIKit

extension UITableView {

  func dequeue<Cell: UITableViewCell>(cell: Cell.Type, indexPath: IndexPath) -> Cell {
    let identifier = String(describing: cell)

    // swiftlint:disable:next force_cast
    return self.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! Cell
  }
}
