import XCTest
@testable import TinyEvents

class TinyEventsTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(TinyEvents().text, "Hello, World!")
    }


    static var allTests = [
        ("testExample", testExample),
    ]
}
