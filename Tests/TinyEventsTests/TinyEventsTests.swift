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
    
    func testFiringRepeatedly() {
        let event = TinyEvent()
        
        let timesToFire = 26
        var timesObserved = 0
        
        withExtendedLifetime(event.add({ timesObserved += 1 })) {
            for _ in 1...timesToFire {
                event.fire()
            }
        }
        
        XCTAssertEqual(timesToFire, timesObserved)
    }
    
    func testRemovingObserver() {
        let event = TinyEvent()
        
        var timesObserved = 0
        
        var observer: TinyEventObserver? = event.add { timesObserved += 1 }
        
        withExtendedLifetime(observer) {
            event.fire()
        }
        
        XCTAssertEqual(timesObserved, 1)
        
        observer = nil
        
        event.fire()
        
        XCTAssertEqual(timesObserved, 1)
    }
    
    func testMultipleObservers() {
        let event = TinyEvent()
        
        var timesObserved = 0
        let observerCount = 33
        
        var observers = [TinyEventObserver]()
        
        for _ in 1...observerCount {
            observers.append(event.add { timesObserved += 1 })
        }
        
        event.fire()
        
        XCTAssertEqual(observerCount, timesObserved)
    }
    
    func testWithMultiplePiecesOfData() {
        let event = TinyEventWithData<(String, Int)>()
        
        var titleFromObserver: String? = nil
        var ratingFromObserver: Int? = nil
        
        let observer = event.add { title, rating in
            titleFromObserver = title
            ratingFromObserver = rating
        }
        withExtendedLifetime(observer) {
            event.fire(("TinyEvents", Int.max))
        }
        
        XCTAssertNotNil(titleFromObserver)
        XCTAssertNotNil(ratingFromObserver)
    }
    
    static var allTests = [
        ("testSimple", testSimple),
        ("testWithIntData", testWithIntData),
        ("testFiringRepeatedly", testFiringRepeatedly),
        ("testRemovingObserver", testRemovingObserver),
        ("testMultipleObservers", testMultipleObservers),
        ("testWithMultiplePiecesOfData", testWithMultiplePiecesOfData),
    ]
    
}
