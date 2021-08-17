import Foundation
import Combine

struct ImportFileViewModel: Identifiable {
  let header: String
  let exampletext: String

  var id: String { header }
}

class ImportFilePresenter: ObservableObject {
  @Published var items: [ImportFileViewModel] = []
  @Published var fileType: String
  private var selectedHeaders: [String] = []

  init(file: ImportFile) {
    self.items = file.headers.enumerated().map { index, header in
      let example = file.rows[0][index]
      return ImportFileViewModel(header: header, exampletext: example)
    }
    self.fileType = file.type.rawValue.uppercased()
  }

  func didSelect(item: ImportFileViewModel) {
    selectedHeaders.append(item.header)
  }

  func didUnselect(item: ImportFileViewModel) {
    selectedHeaders.remove(item.header)
  }
}
