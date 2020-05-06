import UIKit

protocol AddCategoryDelegate: class {
  func didAddCategory(with name: String)
}

class AddCategoryModuleBuilder {

  func build(delegate: AddCategoryDelegate) -> UIViewController {
    let alert = UIAlertController(title: localize("Add a category"), message: "", preferredStyle: .alert)
    alert.addTextField { textField in
      textField.placeholder = localize("Category name...")
    }

    alert.addAction(.init(title: localize("Save"), style: .default, handler: { _ in
      if let text = alert.textFields?.first?.text,
        !text.isEmpty {
        delegate.didAddCategory(with: text)
      }
    }))
    alert.addAction(.init(title: localize("Cancel"), style: .default, handler: nil))

    return alert
  }
}
