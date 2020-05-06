import Foundation

struct ExpenseCategoryViewModel {
  let categoryId: String
  let name: String
  let isSelected: Bool
}

extension ExpenseCategoryViewModel: Equatable {

  static func == (lhs: ExpenseCategoryViewModel, rhs: ExpenseCategoryViewModel) -> Bool {
    lhs.categoryId == rhs.categoryId
  }
}

protocol CategorySelectorView: class {
  func showCategories(_ categories: [ExpenseCategoryViewModel])
}

class CategorySelectorPresenter {

  private weak var view: CategorySelectorView?
  private weak var delegate: CategorySelectorDelegate?
  private let router: CategorySelectorRouter
  private let repository: ExpensesRepository

  private var selectedCategories: [ExpenseCategoryViewModel]

  init(
    view: CategorySelectorView,
    delegate: CategorySelectorDelegate,
    selectedCategories: [ExpenseCategory],
    router: CategorySelectorRouter,
    repository: ExpensesRepository
  ) {
    self.view = view
    self.delegate = delegate
    self.router = router
    self.repository = repository

    self.selectedCategories = selectedCategories.map {
      ExpenseCategoryViewModel(categoryId: $0.categoryId, name: $0.name, isSelected: true)
    }
  }

  func viewIsReady() {
    self.refresh()
  }

  func userAddCategory() {
    self.router.navigateToAddCategory(delegate: self)
  }

  func userDidSelectCategory(_ category: ExpenseCategoryViewModel) {
    self.selectedCategories.append(category)
  }

  func userDidDeselectCategory(_ category: ExpenseCategoryViewModel) {
    self.selectedCategories.remove(category)
  }

  func userDone() {
    let selectedCategories = self.selectedCategories.map {
      ExpenseCategory(categoryId: $0.categoryId, name: $0.name)
    }
    self.delegate?.didSelectCategories(selectedCategories)
    self.router.navigateBack()
  }

  private func refresh() {
    let categories = self.repository.allCategories().map { category -> ExpenseCategoryViewModel in
      let isSelected = self.selectedCategories.contains(where: { $0.categoryId == category.categoryId })

      return ExpenseCategoryViewModel(
        categoryId: category.categoryId,
        name: category.name,
        isSelected: isSelected
      )
    }
    self.view?.showCategories(categories)
  }
}

extension CategorySelectorPresenter: AddCategoryDelegate {

  func didAddCategory(with name: String) {
    let category = ExpenseCategory(categoryId: UUID().uuidString, name: name)
    if self.repository.addCategory(category) {
      self.refresh()
    }
  }
}
