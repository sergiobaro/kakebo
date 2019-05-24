import Foundation

//class DateFormFieldPresenter {
//  
//  weak var formDelegate: FormFieldDelegate?
//  var field: FormFieldModel!
//
//  private weak var view: InputFormFieldViewProtocol?
//  
//  private let formatter: GeneralDateFormatter
//  private var text = ""
//
//  init(view: InputFormFieldViewProtocol, formatter: GeneralDateFormatter) {
//    self.view = view
//    self.formatter = formatter
//  }
//
//  private func updateValue(_ string: String) {
//    self.text = self.formatter.trim(string: string)
//
//    let value = self.formatter.string(string: self.text)
//    self.view?.updateValue(value)
//    
//    self.field.value = self.value
//    self.formDelegate?.fieldDidChange(self.field)
//  }
//}
//
//extension DateFormFieldPresenter: InputFormFieldPresenter {
//
//  var value: Any? {
//    get {
//      if self.text.isEmpty {
//        return Date()
//      }
//      return self.formatter.date(string: self.text)
//    }
//    set {
//      let value = self.formatter.string(date: (newValue as? Date) ?? Date())
//      self.updateValue(value)
//    }
//  }
//
//  var hasText: Bool {
//    return !self.text.isEmpty
//  }
//
//  func userInsertText(_ text: String) {
//    guard text != "\n" else {
//      self.formDelegate?.fieldDidEndEditing(self.field)
//      return
//    }
//
//    let newValue = self.text + text
//    self.updateValue(newValue)
//  }
//
//  func userDeleteBackward() {
//    guard !self.text.isEmpty else {
//      return
//    }
//
//    let newValue = String(self.text.dropLast())
//    self.updateValue(newValue)
//  }
//}
