import Foundation

protocol DateRangeSelectorView: class {

  func showComponents(_ components: PickerComponents)
}

class DateRangeSelectorPresenter {

  private weak var view: DateRangeSelectorView?
  private let repository: ExpensesRepository

  init(view: DateRangeSelectorView, repository: ExpensesRepository) {
    self.view = view
    self.repository = repository
  }

  func viewIsReady() {
    let components = makeComponents()

    self.view?.showComponents(components)
  }
}

// MARK: - Private
private extension DateRangeSelectorPresenter {

  func makeComponents() -> PickerComponents {
    
    PickerComponents {
      $0.addComponent(values: makeMonths())
      $0.addComponent(values: makeYears())
    }
  }

  func makeYears() -> [String] {
    guard let expense = self.repository.allExpenses().last else { return [] }

    let year = Calendar.current.component(.year, from: expense.createdAt)
    let currentYear = Calendar.current.component(.year, from: Date())
    if year >= currentYear {
      return [String(year)]
    }

    return (year...currentYear).map(String.init)
  }

  func makeMonths() -> [String] {
    DateFormatter().monthSymbols ?? []
  }
}
