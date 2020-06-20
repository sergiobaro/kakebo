import UIKit

class DateRangeSelectorViewController: UIViewController {

  @IBOutlet private weak var pickerView: UIPickerView!

  var presenter: DateRangeSelectorPresenter!

  private var components = PickerComponents()

  override func viewDidLoad() {
    super.viewDidLoad()

    self.setupView()
    self.presenter.viewIsReady()
  }

  private func setupView() {
    self.title = localize("Select a month")
    self.navigationItem.leftBarButtonItem = .cancel(delegate: self)
    self.navigationItem.rightBarButtonItem = .save(delegate: self)

    self.pickerView.dataSource = self
    self.pickerView.delegate = self
  }
}

extension DateRangeSelectorViewController: DateRangeSelectorView {

  func selectComponent(_ component: Int, index: Int) {
    self.pickerView.selectRow(index, inComponent: component, animated: false)
  }

  func showComponents(_ components: PickerComponents) {
    self.components = components
    self.pickerView.reloadAllComponents()
  }
}

extension DateRangeSelectorViewController: CancelBarButtonDelegate, SaveBarButtonDelegate {

  func tapCancel() {
    self.presenter.userDidCancel()
  }

  func tapSave() {
    self.presenter.userDidSave()
  }
}

extension DateRangeSelectorViewController: UIPickerViewDataSource {

  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    self.components.count
  }

  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    self.components[component].count
  }

  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    self.components[component][row].title
  }
}

extension DateRangeSelectorViewController: UIPickerViewDelegate {

  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    let value = self.components[component][row]
    self.presenter.userDidSelect(value: value, in: component)
  }
}
