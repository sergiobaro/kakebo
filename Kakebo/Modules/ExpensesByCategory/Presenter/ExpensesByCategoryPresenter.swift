import Foundation

struct ExpensesByCategoryViewModel {
  let categoryId: String
  let categoryName: String
  let amount: String
}

private struct CategoryAmount {
  let categoryId: String
  let categoryName: String
  let amount: Int
}

protocol ExpensesByCategoryView: class {
  func showTitle(_ title: String)
  func showViewModels(_ viewModels: [ExpensesByCategoryViewModel])
}

class ExpensesByCategoryPresenter {

  private weak var view: ExpensesByCategoryView?
  private let router: ExpensesByCategoryRouter
  private let expensesRepository: ExpensesRepository
  private let categoriesRepository: ExpenseCategoriesRepository

  private let amountFormatter = AmountFormatter()
  private var currentStartDate = Date().startOfMonth()
  private var currentEndDate = Date().endOfMonth()

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
    self.updateView()
  }

  func userTapFilter() {
    let model = DateRangeSelectorModel(startDate: self.currentStartDate, endDate: self.currentEndDate)
    self.router.navigateToDateRangeSelector(model: model, delegate: self)
  }

  func userTapClose() {
    self.router.navigateBack()
  }

  // MARK: - Private

  func updateView() {
    self.showTitle(from: self.currentStartDate)
    self.showViewModels(startDate: self.currentStartDate, endDate: self.currentEndDate)
  }

  private func showTitle(from date: Date) {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMM YYYY"
    let title = dateFormatter.string(from: date)
    
    self.view?.showTitle(title)
  }

  private func showViewModels(startDate: Date, endDate: Date) {
    let categories = self.categoriesRepository.allCategories()
    let expenses = self.expensesRepository.findBetween(start: startDate, end: endDate)
    let viewModels = self.group(expenses, with: categories)

    self.view?.showViewModels(viewModels)
  }

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

extension ExpensesByCategoryPresenter: DateRangeSelectorDelegate {

  func dateSelectorDidSelect(startDate: Date, endDate: Date) {
    self.currentStartDate = startDate
    self.currentEndDate = endDate

    self.updateView()
  }
}
