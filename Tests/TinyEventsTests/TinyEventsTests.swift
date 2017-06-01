import XCTest
@testable import TinyEvents

class TinyEventsTests: XCTestCase {
    
    func testSimple() {
        let event = TinyEvent()
        var didFire = false
        let observer = event.add {
            didFire = true
        }
        withExtendedLifetime(observer) {
            XCTAssertFalse(didFire)
            event.fire()
            XCTAssertTrue(didFire)
        }
    }
    
    static var allTests = [
        ("testSimple", testSimple),
    ]
    
}
