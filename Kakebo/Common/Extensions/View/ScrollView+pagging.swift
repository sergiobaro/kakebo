import UIKit

extension UIScrollView {

  func scrollTo(page: Int, animated: Bool) {
    let pageX = CGFloat(page) * self.frame.width
    let pageRect = CGRect(x: pageX, y: 0, width: self.frame.width, height: self.frame.height)

    self.scrollRectToVisible(pageRect, animated: animated)
  }

  func setPage(_ page: Int, view: UIView) {
    self.addSubview(view)

    let left = CGFloat(page) * self.frame.width

    view.snp.makeConstraints { (maker) in
      maker.top.equalTo(self.snp.top)
      maker.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
      maker.left.equalTo(left)
      maker.width.equalTo(self.frame.width)
    }
  }
}
