import Foundation

class Sections<Group: Comparable & Hashable, Element: Comparable> {
  
  private class Section: Comparable {
    
    let section: Group
    var elements: [Element]
    
    init(section: Group, elements: [Element]) {
      self.section = section
      self.elements = elements
    }
    
    static func < (lhs: Section, rhs: Section) -> Bool {
      return lhs.section < rhs.section
    }
    
    static func == (lhs: Section, rhs: Section) -> Bool {
      return lhs.section == rhs.section
    }
  }
  
  private var sections: [Section]
  
  // MARK: - Init
  
  convenience init() {
    self.init(sections: [])
  }
  
  private init(sections: [Section]) {
    self.sections = sections
  }
  
  convenience init(elements: [Element], groupBy: (Element) -> Group) {
    let sections = elements
      .group(by: groupBy)
      .reduce(into: [Section]()) { result, group in
        let (section, elements) = group
        result.append(Section(section: section, elements: elements.sorted(by: >)))
      }
      .sorted(by: >)

    self.init(sections: sections)
  }
  
  // MARK: - Public
  
  var numberOfSections: Int {
    return self.sections.count
  }
  
  func section(at index: Int) -> Group? {
    return self.sections.element(at: index)?.section
  }
  
  func numberOfElements(section: Int) -> Int {
    guard let count = self.sections.element(at: section)?.elements.count else {
      return 0
    }
    
    return count
  }
  
  func elements(section: Int) -> [Element] {
    return self.sections.element(at: section)?.elements ?? []
  }
  
  func element(at indexPath: IndexPath) -> Element? {
    return self.sections.element(at: indexPath.section)?.elements.element(at: indexPath.row)
  }
  
  @discardableResult
  func deleteElement(at indexPath: IndexPath) -> Bool {
    guard let section = self.sections.element(at: indexPath.section) else {
      return false
    }
    
    let element = section.elements.removeElement(at: indexPath.row)
    
    if section.elements.isEmpty {
      self.delete(section: indexPath.section)
    }
    
    return (element != nil)
  }
  
  @discardableResult
  func delete(section: Int) -> Bool {
    let section = self.sections.removeElement(at: section)
    return (section != nil)
  }
}
