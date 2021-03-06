// Generated using Sourcery 0.17.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT



// Generated with SwiftyMocky 3.5.0

import SwiftyMocky
#if !MockyCustom
import XCTest
#endif
import UIKit
@testable import Kakebo


// MARK: - FormController
open class FormControllerMock: FormController, Mock {
    init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }





    open func showCustomKeyboard(_ keyboardView: UIView) {
        addInvocation(.m_showCustomKeyboard__keyboardView(Parameter<UIView>.value(`keyboardView`)))
		let perform = methodPerformValue(.m_showCustomKeyboard__keyboardView(Parameter<UIView>.value(`keyboardView`))) as? (UIView) -> Void
		perform?(`keyboardView`)
    }

    open func pushViewController(_ viewController: UIViewController) {
        addInvocation(.m_pushViewController__viewController(Parameter<UIViewController>.value(`viewController`)))
		let perform = methodPerformValue(.m_pushViewController__viewController(Parameter<UIViewController>.value(`viewController`))) as? (UIViewController) -> Void
		perform?(`viewController`)
    }


    fileprivate enum MethodType {
        case m_showCustomKeyboard__keyboardView(Parameter<UIView>)
        case m_pushViewController__viewController(Parameter<UIViewController>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
            case (.m_showCustomKeyboard__keyboardView(let lhsKeyboardview), .m_showCustomKeyboard__keyboardView(let rhsKeyboardview)):
                guard Parameter.compare(lhs: lhsKeyboardview, rhs: rhsKeyboardview, with: matcher) else { return false } 
                return true 
            case (.m_pushViewController__viewController(let lhsViewcontroller), .m_pushViewController__viewController(let rhsViewcontroller)):
                guard Parameter.compare(lhs: lhsViewcontroller, rhs: rhsViewcontroller, with: matcher) else { return false } 
                return true 
            default: return false
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_showCustomKeyboard__keyboardView(p0): return p0.intValue
            case let .m_pushViewController__viewController(p0): return p0.intValue
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func showCustomKeyboard(_ keyboardView: Parameter<UIView>) -> Verify { return Verify(method: .m_showCustomKeyboard__keyboardView(`keyboardView`))}
        public static func pushViewController(_ viewController: Parameter<UIViewController>) -> Verify { return Verify(method: .m_pushViewController__viewController(`viewController`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func showCustomKeyboard(_ keyboardView: Parameter<UIView>, perform: @escaping (UIView) -> Void) -> Perform {
            return Perform(method: .m_showCustomKeyboard__keyboardView(`keyboardView`), performs: perform)
        }
        public static func pushViewController(_ viewController: Parameter<UIViewController>, perform: @escaping (UIViewController) -> Void) -> Perform {
            return Perform(method: .m_pushViewController__viewController(`viewController`), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let invocations = matchingCalls(method.method)
        MockyAssert(count.matches(invocations.count), "Expected: \(count) invocations of `\(method.method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType) -> [MethodType] {
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }
    private func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        #if Mocky
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleMissingStubError(message: message, file: file, line: line)
        #endif
    }
}

// MARK: - FormFieldDelegate
open class FormFieldDelegateMock: FormFieldDelegate, Mock {
    init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }





    open func fieldDidChange(_ field: FormFieldModel) {
        addInvocation(.m_fieldDidChange__field(Parameter<FormFieldModel>.value(`field`)))
		let perform = methodPerformValue(.m_fieldDidChange__field(Parameter<FormFieldModel>.value(`field`))) as? (FormFieldModel) -> Void
		perform?(`field`)
    }

    open func fieldDidBeginEditing(_ field: FormFieldModel) {
        addInvocation(.m_fieldDidBeginEditing__field(Parameter<FormFieldModel>.value(`field`)))
		let perform = methodPerformValue(.m_fieldDidBeginEditing__field(Parameter<FormFieldModel>.value(`field`))) as? (FormFieldModel) -> Void
		perform?(`field`)
    }

    open func fieldDidEndEditing(_ field: FormFieldModel) {
        addInvocation(.m_fieldDidEndEditing__field(Parameter<FormFieldModel>.value(`field`)))
		let perform = methodPerformValue(.m_fieldDidEndEditing__field(Parameter<FormFieldModel>.value(`field`))) as? (FormFieldModel) -> Void
		perform?(`field`)
    }

    open func fieldDidSelect(_ field: FormFieldModel) {
        addInvocation(.m_fieldDidSelect__field(Parameter<FormFieldModel>.value(`field`)))
		let perform = methodPerformValue(.m_fieldDidSelect__field(Parameter<FormFieldModel>.value(`field`))) as? (FormFieldModel) -> Void
		perform?(`field`)
    }


    fileprivate enum MethodType {
        case m_fieldDidChange__field(Parameter<FormFieldModel>)
        case m_fieldDidBeginEditing__field(Parameter<FormFieldModel>)
        case m_fieldDidEndEditing__field(Parameter<FormFieldModel>)
        case m_fieldDidSelect__field(Parameter<FormFieldModel>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
            case (.m_fieldDidChange__field(let lhsField), .m_fieldDidChange__field(let rhsField)):
                guard Parameter.compare(lhs: lhsField, rhs: rhsField, with: matcher) else { return false } 
                return true 
            case (.m_fieldDidBeginEditing__field(let lhsField), .m_fieldDidBeginEditing__field(let rhsField)):
                guard Parameter.compare(lhs: lhsField, rhs: rhsField, with: matcher) else { return false } 
                return true 
            case (.m_fieldDidEndEditing__field(let lhsField), .m_fieldDidEndEditing__field(let rhsField)):
                guard Parameter.compare(lhs: lhsField, rhs: rhsField, with: matcher) else { return false } 
                return true 
            case (.m_fieldDidSelect__field(let lhsField), .m_fieldDidSelect__field(let rhsField)):
                guard Parameter.compare(lhs: lhsField, rhs: rhsField, with: matcher) else { return false } 
                return true 
            default: return false
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_fieldDidChange__field(p0): return p0.intValue
            case let .m_fieldDidBeginEditing__field(p0): return p0.intValue
            case let .m_fieldDidEndEditing__field(p0): return p0.intValue
            case let .m_fieldDidSelect__field(p0): return p0.intValue
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func fieldDidChange(_ field: Parameter<FormFieldModel>) -> Verify { return Verify(method: .m_fieldDidChange__field(`field`))}
        public static func fieldDidBeginEditing(_ field: Parameter<FormFieldModel>) -> Verify { return Verify(method: .m_fieldDidBeginEditing__field(`field`))}
        public static func fieldDidEndEditing(_ field: Parameter<FormFieldModel>) -> Verify { return Verify(method: .m_fieldDidEndEditing__field(`field`))}
        public static func fieldDidSelect(_ field: Parameter<FormFieldModel>) -> Verify { return Verify(method: .m_fieldDidSelect__field(`field`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func fieldDidChange(_ field: Parameter<FormFieldModel>, perform: @escaping (FormFieldModel) -> Void) -> Perform {
            return Perform(method: .m_fieldDidChange__field(`field`), performs: perform)
        }
        public static func fieldDidBeginEditing(_ field: Parameter<FormFieldModel>, perform: @escaping (FormFieldModel) -> Void) -> Perform {
            return Perform(method: .m_fieldDidBeginEditing__field(`field`), performs: perform)
        }
        public static func fieldDidEndEditing(_ field: Parameter<FormFieldModel>, perform: @escaping (FormFieldModel) -> Void) -> Perform {
            return Perform(method: .m_fieldDidEndEditing__field(`field`), performs: perform)
        }
        public static func fieldDidSelect(_ field: Parameter<FormFieldModel>, perform: @escaping (FormFieldModel) -> Void) -> Perform {
            return Perform(method: .m_fieldDidSelect__field(`field`), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let invocations = matchingCalls(method.method)
        MockyAssert(count.matches(invocations.count), "Expected: \(count) invocations of `\(method.method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType) -> [MethodType] {
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }
    private func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        #if Mocky
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleMissingStubError(message: message, file: file, line: line)
        #endif
    }
}

// MARK: - FormViewDelegate
open class FormViewDelegateMock: FormViewDelegate, Mock {
    init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }





    open func formFieldDidChange(_ field: FormFieldModel) {
        addInvocation(.m_formFieldDidChange__field(Parameter<FormFieldModel>.value(`field`)))
		let perform = methodPerformValue(.m_formFieldDidChange__field(Parameter<FormFieldModel>.value(`field`))) as? (FormFieldModel) -> Void
		perform?(`field`)
    }

    open func formDidFinish(with fields: [FormFieldModel]) {
        addInvocation(.m_formDidFinish__with_fields(Parameter<[FormFieldModel]>.value(`fields`)))
		let perform = methodPerformValue(.m_formDidFinish__with_fields(Parameter<[FormFieldModel]>.value(`fields`))) as? ([FormFieldModel]) -> Void
		perform?(`fields`)
    }

    open func formDidSelect(_ field: FormFieldModel) {
        addInvocation(.m_formDidSelect__field(Parameter<FormFieldModel>.value(`field`)))
		let perform = methodPerformValue(.m_formDidSelect__field(Parameter<FormFieldModel>.value(`field`))) as? (FormFieldModel) -> Void
		perform?(`field`)
    }


    fileprivate enum MethodType {
        case m_formFieldDidChange__field(Parameter<FormFieldModel>)
        case m_formDidFinish__with_fields(Parameter<[FormFieldModel]>)
        case m_formDidSelect__field(Parameter<FormFieldModel>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
            case (.m_formFieldDidChange__field(let lhsField), .m_formFieldDidChange__field(let rhsField)):
                guard Parameter.compare(lhs: lhsField, rhs: rhsField, with: matcher) else { return false } 
                return true 
            case (.m_formDidFinish__with_fields(let lhsFields), .m_formDidFinish__with_fields(let rhsFields)):
                guard Parameter.compare(lhs: lhsFields, rhs: rhsFields, with: matcher) else { return false } 
                return true 
            case (.m_formDidSelect__field(let lhsField), .m_formDidSelect__field(let rhsField)):
                guard Parameter.compare(lhs: lhsField, rhs: rhsField, with: matcher) else { return false } 
                return true 
            default: return false
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_formFieldDidChange__field(p0): return p0.intValue
            case let .m_formDidFinish__with_fields(p0): return p0.intValue
            case let .m_formDidSelect__field(p0): return p0.intValue
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func formFieldDidChange(_ field: Parameter<FormFieldModel>) -> Verify { return Verify(method: .m_formFieldDidChange__field(`field`))}
        public static func formDidFinish(with fields: Parameter<[FormFieldModel]>) -> Verify { return Verify(method: .m_formDidFinish__with_fields(`fields`))}
        public static func formDidSelect(_ field: Parameter<FormFieldModel>) -> Verify { return Verify(method: .m_formDidSelect__field(`field`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func formFieldDidChange(_ field: Parameter<FormFieldModel>, perform: @escaping (FormFieldModel) -> Void) -> Perform {
            return Perform(method: .m_formFieldDidChange__field(`field`), performs: perform)
        }
        public static func formDidFinish(with fields: Parameter<[FormFieldModel]>, perform: @escaping ([FormFieldModel]) -> Void) -> Perform {
            return Perform(method: .m_formDidFinish__with_fields(`fields`), performs: perform)
        }
        public static func formDidSelect(_ field: Parameter<FormFieldModel>, perform: @escaping (FormFieldModel) -> Void) -> Perform {
            return Perform(method: .m_formDidSelect__field(`field`), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let invocations = matchingCalls(method.method)
        MockyAssert(count.matches(invocations.count), "Expected: \(count) invocations of `\(method.method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType) -> [MethodType] {
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }
    private func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        #if Mocky
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleMissingStubError(message: message, file: file, line: line)
        #endif
    }
}

// MARK: - InputFormFieldViewProtocol
open class InputFormFieldViewProtocolMock: InputFormFieldViewProtocol, Mock {
    init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }





    open func updateText(_ text: String?) {
        addInvocation(.m_updateText__text(Parameter<String?>.value(`text`)))
		let perform = methodPerformValue(.m_updateText__text(Parameter<String?>.value(`text`))) as? (String?) -> Void
		perform?(`text`)
    }


    fileprivate enum MethodType {
        case m_updateText__text(Parameter<String?>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
            case (.m_updateText__text(let lhsText), .m_updateText__text(let rhsText)):
                guard Parameter.compare(lhs: lhsText, rhs: rhsText, with: matcher) else { return false } 
                return true 
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_updateText__text(p0): return p0.intValue
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func updateText(_ text: Parameter<String?>) -> Verify { return Verify(method: .m_updateText__text(`text`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func updateText(_ text: Parameter<String?>, perform: @escaping (String?) -> Void) -> Perform {
            return Perform(method: .m_updateText__text(`text`), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let invocations = matchingCalls(method.method)
        MockyAssert(count.matches(invocations.count), "Expected: \(count) invocations of `\(method.method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType) -> [MethodType] {
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }
    private func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        #if Mocky
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleMissingStubError(message: message, file: file, line: line)
        #endif
    }
}

