import Foundation

protocol DateRangeSelectorView: class {
  func selectComponent(_ component: Int, index: Int)
  func showComponents(_ components: PickerComponents)
}

private struct DateRangeIndex {
  static let month = 0
  static let year = 1
}

class DateRangeSelectorPresenter {

  private weak var view: DateRangeSelectorView?
  private weak var delegate: DateRangeSelectorDelegate?
  private let router: DateRangeSelectorRouter
  private let repository: ExpensesRepository

  private let model: DateRangeSelectorModel
  private var selectedValues = [Int: PickerComponents.Value]()

  init(
    model: DateRangeSelectorModel,
    view: DateRangeSelectorView,
    delegate: DateRangeSelectorDelegate,
    router: DateRangeSelectorRouter,
    repository: ExpensesRepository
  ) {
    self.model = model
    self.view = view
    self.delegate = delegate
    self.router = router
    self.repository = repository
  }

  func viewIsReady() {
    let components = makeComponents()
    self.view?.showComponents(components)

    let dateComponents = Calendar.current.dateComponents([.month, .year], from: self.model.startDate)

    // selected month
    let month = dateComponents.month!
    let monthComponent = components[DateRangeIndex.month]
    if let monthIndex = monthComponent.values.firstIndex(where: { $0.value == month }) {
      self.selectedValues[DateRangeIndex.month] = monthComponent[monthIndex]
      self.view?.selectComponent(DateRangeIndex.month, index: monthIndex)
    }

    // selected year
    let year = dateComponents.year!
    let yearComponent = components[DateRangeIndex.year]
    if let yearIndex = yearComponent.values.firstIndex(where: { $0.value == year }) {
      self.selectedValues[DateRangeIndex.year] = yearComponent[yearIndex]
      self.view?.selectComponent(DateRangeIndex.year, index: yearIndex)
    }
  }

  func userDidSave() {
    if let (startDate, endDate) = self.makeDates() {
      self.delegate?.dateSelectorDidSelect(startDate: startDate, endDate: endDate)
    }

    self.router.navigateBack()
  }

  func userDidCancel() {
    self.router.navigateBack()
  }

  func userDidSelect(value: PickerComponents.Value, in component: Int) {
    self.selectedValues[component] = value
  }
}

// MARK: - Private
private extension DateRangeSelectorPresenter {

  func makeComponents() -> PickerComponents {
    PickerComponents {
      $0.addComponent(values: makeMonthValues())
      $0.addComponent(values: makeYearValues())
    }
  }

  func makeYearValues() -> [PickerComponents.Value] {
    guard let expense = self.repository.allExpenses().last else { return [] }

    let year = Calendar.current.component(.year, from: expense.createdAt)
    let currentYear = Calendar.current.component(.year, from: Date())
    guard year < currentYear else {
      return [.init(title: String(year), value: year)]
    }

    return (year...currentYear).map { year -> PickerComponents.Value in
      .init(title: String(year), value: year)
    }
  }

  func makeMonthValues() -> [PickerComponents.Value] {
    (DateFormatter().monthSymbols ?? [])
      .enumerated()
      .map { (index, month) -> PickerComponents.Value in
        .init(title: month, value: index + 1)
      }
  }

  func makeDates() -> (startDate: Date, endDate: Date)? {
    guard let (month, year) = self.makeValues() else {
      return nil
    }

    let components = DateComponents(year: year, month: month)
    guard let date = Calendar.current.date(from: components) else {
      return nil
    }

    return (date.startOfMonth(), date.endOfMonth())
  }

  func makeValues() -> (month: Int, year: Int)? {
    guard let month = self.selectedValues[DateRangeIndex.month]?.value,
      let year = self.selectedValues[DateRangeIndex.year]?.value else {
        return nil
    }

    return (month, year)
  }
}
