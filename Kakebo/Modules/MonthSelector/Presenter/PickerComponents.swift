import Foundation

class PickerComponents {
  struct Component {
    var count: Int { self.values.count }

    private let values: [String]
    init(values: [String]) {
      self.values = values
    }

    func value(at index: Int) -> String? {
      self.values.element(at: index)
    }
  }

  var count: Int { self.components.count }

  private var components = [Component]()

  func component(at index: Int) -> Component? {
    self.components.element(at: index)
  }

  func addComponent(values: [String]) {
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
