#if !canImport(ObjectiveC)
import XCTest

extension TinyEventsTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__TinyEventsTests = [
        ("testEventDestroyedBeforeObserver", testEventDestroyedBeforeObserver),
        ("testFiringRepeatedly", testFiringRepeatedly),
        ("testMultipleObservers", testMultipleObservers),
        ("testRemovingObserver", testRemovingObserver),
        ("testSimple", testSimple),
        ("testWithIntData", testWithIntData),
        ("testWithMultiplePiecesOfData", testWithMultiplePiecesOfData),
    ]
}

public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(TinyEventsTests.__allTests__TinyEventsTests),
    ]
}
#endif
