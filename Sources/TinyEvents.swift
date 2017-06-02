public class TinyEventWithData<T> {
    
    public init() {}
    
    public func add(_ callback: @escaping (T) -> Void) -> TinyEventWithDataObserver<T> {
        let observer = TinyEventWithDataObserver(event: self, callback: callback)
        observers.append(WeakTinyEventObserver(observer: observer))
        return observer
    }
    
    public func fire(_ parameter: T) {
        var anObserverHasBeenDeallocated = false
        for observer in observers {
            if let o = observer.observer {
                o.callback(parameter)
            } else {
                // I have seen this happen in the wild, but I'm afraid I can't remember and can't figure out how it happened, so this needs more investigation. The code does the safe thing anyway.
                anObserverHasBeenDeallocated = true
            }
        }
        
        if anObserverHasBeenDeallocated {
            observers = observers.filter { $0.observer != nil }
        }
    }
    
    fileprivate func removeDeadObserver() {
        guard let observerIndex = observers.index(where: { $0.observer == nil }) else { return }
        observers.remove(at: observerIndex)
    }
    
    private var observers = [WeakTinyEventObserver]()
    // This struct only exists because we want to store weak references in the above array:
    private struct WeakTinyEventObserver {
        weak var observer: TinyEventWithDataObserver<T>?
    }
    
}

public class TinyEventWithDataObserver<T> {
    
    fileprivate init(event: TinyEventWithData<T>, callback: @escaping (T) -> Void) {
        self.event = event
        self.callback = callback
    }
    
    fileprivate let callback: (T) -> Void
    private weak var event: TinyEventWithData<T>?
    
    deinit {
        guard let event = event else { return }
        // We want to remove ourselves from the event. At this point (when we're being deinitialized) the weak reference that the event holds for us is already `nil` so instead of passing a reference to ourselves we can just tell it to remove the `nil`:
        event.removeDeadObserver()
    }
    
}

public typealias TinyEvent = TinyEventWithData<Void>
public typealias TinyEventObserver = TinyEventWithDataObserver<Void>
