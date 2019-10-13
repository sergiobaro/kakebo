import UIKit

class CalendarFormFieldKeyboardView: UIView {
  
  @IBOutlet private weak var collectionView: UICollectionView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    self.backgroundColor = .clear
    
    self.collectionView.backgroundColor = .black
    self.collectionView.delegate = self
    self.collectionView.dataSource = self
    self.collectionView.isPagingEnabled = true
    
    if let flowLayout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
      flowLayout.minimumLineSpacing = 0.0
      flowLayout.scrollDirection = .horizontal
    }
    
    self.collectionView.register(CalendarFormFieldViewCell.self)
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    
    if let flowLayout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
      flowLayout.itemSize = CGSize(width: self.collectionView.bounds.width, height: self.collectionView.bounds.height)
    }
  }
}

extension CalendarFormFieldKeyboardView: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return 5
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeue(CalendarFormFieldViewCell.self, indexPath: indexPath)!
    cell.backgroundColor = UIColor.random
    return cell
  }
}

extension CalendarFormFieldKeyboardView: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      print(indexPath.item + 1)
  }
}
