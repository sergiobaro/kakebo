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
  private let router: ExpensesByCategoryRouter
  private let expensesRepository: ExpensesRepository
  private let categoriesRepository: ExpenseCategoriesRepository

  private let amountFormatter = AmountFormatter()

  init(
    view: ExpensesByCategoryView,
    router: ExpensesByCategoryRouter,
    expensesRepository: ExpensesRepository,
    categoriesRepository: ExpenseCategoriesRepository
  ) {
    self.view = view
    self.router = router
    self.expensesRepository = expensesRepository
    self.categoriesRepository = categoriesRepository
  }

  func viewIsReady() {
    let categories = self.categoriesRepository.allCategories()

    let start = Date().startOfMonth()
    let end = Date().endOfMonth()
    let expenses = self.expensesRepository.findBetween(start: start, end: end)

    let viewModels = self.group(expenses, with: categories)

    self.view?.showViewModels(viewModels)
  }

  func userTapFilter() {
    self.router.navigateToFilter()
  }

  func userTapClose() {
    self.router.navigateBack()
  }

  // MARK: - Private

  private func group(_ expenses: [Expense], with categories: [ExpenseCategory]) -> [ExpensesByCategoryViewModel] {
    var result = [ExpenseCategory: Int]()
    for category in categories {
      result[category] = 0
    }

    for expense in expenses {
      for category in expense.categories {
        result[category]! += expense.amount
      }
    }

    return result
      .map { (category, amount) -> CategoryAmount in
        CategoryAmount(
          categoryId: category.categoryId,
          categoryName: category.name,
          amount: amount
        )
      }
      .sorted { $0.amount > $1.amount }
      .map {
        ExpensesByCategoryViewModel(
          categoryId: $0.categoryId,
          categoryName: $0.categoryName,
          amount: self.amountFormatter.string(integer: $0.amount)
        )
      }
  }
}

private struct CategoryAmount {
  let categoryId: String
  let categoryName: String
  let amount: Int
}
