import Foundation

class PickerComponents {

  struct Component {
    var count: Int { self.values.count }
    let values: [Value]

    init(values: [Value]) {
      self.values = values
    }

    subscript(index: Int) -> Value {
      self.values[index]
    }
  }

  struct Value {
    let title: String
    let value: Int
  }

  var count: Int { self.components.count }

  private var components = [Component]()

  subscript(index: Int) -> Component {
    self.components[index]
  }

  func addComponent(values: [Value]) {
    let component = Component(values: values)
    self.components.append(component)
  }

  convenience init() {
    self.init(components: [])
  }

  init(components: [Component]) {
    self.components = components
  }

  init(_ builder: (PickerComponents) -> Void) {
    builder(self)
  }
}
