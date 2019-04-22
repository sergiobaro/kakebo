import Foundation

struct Sections<G: Comparable & Hashable, E> {
  
  private class Section: Comparable {
    
    let section: G
    var elements: [E]
    
    init(section: G, elements: [E]) {
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
  
  init() {
    self.init(sections: [])
  }
  
  private init(sections: [Section]) {
    self.sections = sections
  }
  
  init(elements: [E], groupBy: (E) -> G) {
    let groups = elements.group(by: groupBy)
    let sections = groups.reduce(into: [Section]()) { result, group in
      let (section, elements) = group
      result.append(Section(section: section, elements: elements))
    }
    
    self.init(sections: sections)
  }
  
  // MARK: - Public
  
  var numberOfSections: Int {
    return self.sections.count
  }
  
  func section(at index: Int) -> G? {
    return self.sections.element(at: index)?.section
  }
  
  func numberOfElements(section: Int) -> Int {
    guard let count = self.sections.element(at: section)?.elements.count else {
      return 0
    }
    
    return count
  }
  
  func element(at indexPath: IndexPath) -> E? {
    return self.sections.element(at: indexPath.section)?.elements.element(at: indexPath.row)
  }
  
  @discardableResult
  func deleteElement(at indexPath: IndexPath) -> Bool {
    guard let section = self.sections.element(at: indexPath.section) else {
      return false
    }
    
    let element = section.elements.removeElement(at: indexPath.row)
    return (element != nil)
  }
}
