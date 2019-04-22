import UIKit

extension UITableView {
  
  func deleteRow(at indexPath: IndexPath, with rowAnimation: UITableView.RowAnimation) {
    self.deleteRows(at: [indexPath], with: rowAnimation)
  }
  
  func deleteSection(at section: Int, with rowAnimation: UITableView.RowAnimation) {
    let set = IndexSet(integer: section)
    self.deleteSections(set, with: rowAnimation)
  }
}
