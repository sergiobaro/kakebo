import SwiftUI

struct ImportFileView: View {
  @ObservedObject var presenter: ImportFilePresenter

  var body: some View {
    List(presenter.items) { item in
      HStack {
        CheckView(checked: false) { checked in
          if checked {
            self.presenter.didSelect(item: item)
          } else {
            self.presenter.didUnselect(item: item)
          }
        }
        .padding(.trailing, 10)
        Text(item.header)
        Spacer()
        Text(item.exampletext)
          .font(.caption)
      }
    }
    .navigationTitle("Import File (\(presenter.fileType))")
  }
}

struct ImportFileView_Previews: PreviewProvider {
  static var previews: some View {
    ImportFileView(presenter: ImportFilePresenter(file: CSVImportFile(headers: [], rows: [])))
  }
}
