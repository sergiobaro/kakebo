import Foundation

struct ExpensesByCategoryViewModel {
  let categoryId: String
  let categoryName: String
  let amount: String
}

protocol ExpensesByCategoryView: class {
  func showViewModels(_ viewModels: [ExpensesByCategoryViewModel])
}

class ExpensesByCategoryPresenter {

  private weak var view: ExpensesByCategoryView?
  private let expensesRepository: ExpensesRepository
  private let categoriesRepository: ExpenseCategoriesRepository

  private let amountFormatter = AmountFormatter()

  init(
    view: ExpensesByCategoryView,
    expensesRepository: ExpensesRepository,
    categoriesRepository: ExpenseCategoriesRepository
  ) {
    self.view = view
    self.expensesRepository = expensesRepository
    self.categoriesRepository = categoriesRepository
  }

  func viewIsReady() {
    let categories = self.categoriesRepository.allCategories()

    let start = Date().startOfMonth()
    let end = Date().endOfMonth()
    let expenses = self.expensesRepository.findBetween(start: start, end: end)

    let viewModels = self.group(expenses, with: categories).map { (category, amount) -> ExpensesByCategoryViewModel in
      ExpensesByCategoryViewModel(
        categoryId: category.categoryId,
        categoryName: category.name,
        amount: self.amountFormatter.string(integer: amount)
      )
    }
    self.view?.showViewModels(viewModels)
  }

  // MARK: - Private

  private func group(_ expenses: [Expense], with categories: [ExpenseCategory]) -> [ExpenseCategory: Int] {
    var result = [ExpenseCategory: Int]()

    for expense in expenses {
      for category in expense.categories {
        let total = (result[category] ?? 0) + expense.amount
        result[category] = total
      }
    }

    return result
  }
}
