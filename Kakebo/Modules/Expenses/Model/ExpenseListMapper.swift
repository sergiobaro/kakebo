import Foundation

struct ExpenseListMapper {
  
  private let amountFormatter = AmountFormatter()
  
  private let createdAtDateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm"
    return dateFormatter
  }()
  
  private let sectionDateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .none
    return dateFormatter
  }()
  
  func map(expense: Expense) -> ExpenseListViewModel {
    return ExpenseListViewModel(
      name: expense.name,
      amount: self.amountFormatter.string(integer: expense.amount),
      date: self.createdAtDateFormatter.string(from: expense.createdAt),
      categories: expense.categories.map({ $0.name }).joined(separator: ", ")
    )
  }
  
  func mapSection(date: Date, expenses: [Expense]) -> ExpenseListSectionViewModel? {
    let dateString = self.sectionDateFormatter.string(from: date)
    let totalAmount = expenses
      .map({ $0.amount })
      .reduce(0) { $0 + $1 }
    let totalString = self.amountFormatter.string(integer: totalAmount)
    
    return ExpenseListSectionViewModel(
      title: dateString,
      totalAmount: totalString
    )
  }
}
