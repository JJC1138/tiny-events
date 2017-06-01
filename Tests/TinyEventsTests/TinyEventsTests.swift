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
    
    func testWithIntData() {
        let event = TinyEventWithData<Int>()
        let data = 1138
        var dataFromObserver = 0
        let observer = event.add { eventData in
            XCTAssertEqual(data, eventData)
            dataFromObserver = eventData
        }
        withExtendedLifetime(observer) {
            event.fire(data)
        }
        XCTAssertEqual(data, dataFromObserver)
    }
    
    static var allTests = [
        ("testSimple", testSimple),
        ("testWithIntData", testWithIntData),
    ]
    
}
