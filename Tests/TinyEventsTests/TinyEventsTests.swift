import XCTest
@testable import TinyEvents

class TinyEventsTests: XCTestCase {
    
    var observers = [TinyEventObserver]()
    
    func testSimple() {
        let event = TinyEvent()
        var didFire = false
        observers.append(event.add {
            didFire = true
        })
        
        XCTAssertFalse(didFire)
        event.fire()
        XCTAssertTrue(didFire)
    }
    
    override func tearDown() {
        observers.removeAll()
        
        super.tearDown()
    }
    
    static var allTests = [
        ("testSimple", testSimple),
    ]
    
}
