import Quick
import Nimble

@testable import Kakebo

class SectionsSpec: QuickSpec {
  override func spec() {
    
    context("get sections and elements") {
      it("when is empty") {
        let sections = Sections<Int, Int>()
        
        expect(sections.numberOfSections).to(equal(0))
        expect(sections.section(at: 0)).to(beNil())
        
        expect(sections.numberOfElements(section: 0)).to(equal(0))
        expect(sections.element(at: IndexPath(row: 0, section: 0))).to(beNil())
      }
      
      it("when has one section") {
        let sections = Sections<Int, Int>(elements: [1, 1, 1], groupBy: { return $0 })
        
        expect(sections.numberOfSections).to(equal(1))
        expect(sections.section(at: 0)).to(equal(1))
        
        expect(sections.numberOfElements(section: 0)).to(equal(3))
        expect(sections.numberOfElements(section: 1)).to(equal(0))
        expect(sections.element(at: IndexPath(row: 0, section: 0))).to(equal(1))
        expect(sections.element(at: IndexPath(row: 0, section: 1))).to(beNil())
      }
    }
    
    context("delete elements") {
      it("when sections is empty") {
        let sections = Sections<Int, Int>()
        
        expect(sections.deleteElement(at: IndexPath(row: 0, section: 0))).to(beFalse())
      }
      it("when has one section") {
        let sections = Sections<Int, Int>(elements: [1, 1, 1], groupBy: { return $0 })
        
        expect(sections.numberOfElements(section: 0)).to(equal(3))
        expect(sections.deleteElement(at: IndexPath(row: 0, section: 0))).to(beTrue())
        expect(sections.numberOfElements(section: 0)).to(equal(2))
        
        expect(sections.deleteElement(at: IndexPath(row: 4, section: 0))).to(beFalse())
      }
    }
    
  }
}
