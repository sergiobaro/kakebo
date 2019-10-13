import UIKit

extension UICollectionView {
  
  func register<Cell: UICollectionViewCell>(_ type: Cell.Type) {
    let identifier = String(describing: type)
    let nib = UINib(nibName: identifier, bundle: nil)
    self.register(nib, forCellWithReuseIdentifier: identifier)
  }
  
  func dequeue<Cell: UICollectionViewCell>(_ type: Cell.Type, indexPath: IndexPath) -> Cell? {
    let identifier = String(describing: type)
    
    return self.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? Cell
  }
}
