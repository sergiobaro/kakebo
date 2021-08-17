import SwiftUI

struct CheckView: View {
  @State var checked: Bool
  let action: (Bool) -> Void

  var body: some View {
    Image(systemName: checked ? "checkmark.square" : "square")
      .resizable()
      .frame(width: 20, height: 20)
      .onTapGesture {
        self.checked.toggle()
        self.action(self.checked)
      }
  }
}
