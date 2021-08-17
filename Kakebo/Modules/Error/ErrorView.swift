import SwiftUI

struct ErrorView: View {
  let errorDescription: String

  var body: some View {
    Text(errorDescription)
      .navigationTitle("Error")
  }
}

struct ErrorView_Previews: PreviewProvider {
  static var previews: some View {
    ErrorView(errorDescription: "error")
  }
}
