import UIKit

class CalendarFormFieldViewCell: UICollectionViewCell {
  
  @IBOutlet private var titleLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    self.backgroundColor = .white

    self.titleLabel.font = FormStyle.textFont
    self.titleLabel.textColor = FormStyle.textColor
    
    let calendar = Calendar.current
    let date = Date()
    
    if let numberOfDays = calendar.range(of: .day, in: .month, for: date)?.count {
      print(numberOfDays)
    }
    self.titleLabel.text = "\(date, format: "MMMM")"

    print("Day of the week: \(calendar.component(.weekday, from: date))")
    print("First Weekday: \(calendar.firstWeekday)")
  }
}

fileprivate extension String.StringInterpolation {
  mutating func appendInterpolation(_ date: Date, format: String) {
    let formatter = DateFormatter()
    formatter.dateFormat = format
    
    appendLiteral(formatter.string(from: date))
  }
}
