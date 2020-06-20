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
    self.navigationItem.leftBarButtonItem = .close(delegate: self)

    self.pickerView.dataSource = self
    self.pickerView.delegate = self
  }
}

extension DateRangeSelectorViewController: DateRangeSelectorView {

  func showComponents(_ components: PickerComponents) {
    self.components = components
    self.pickerView.reloadAllComponents()
  }
}

extension DateRangeSelectorViewController: CloseBarButtonDelegate {

  func tapClose() {
    self.dismiss(animated: true, completion: nil)
  }
}

extension DateRangeSelectorViewController: UIPickerViewDataSource {

  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    self.components.count
  }

  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    self.components.component(at: component)?.count ?? 0
  }

  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    self.components.component(at: component)?.value(at: row) ?? ""
  }
}

extension DateRangeSelectorViewController: UIPickerViewDelegate {

}
