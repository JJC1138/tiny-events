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
                anObserverHasBeenDeallocated = true
            }
        }
        
        if anObserverHasBeenDeallocated {
            observers = observers.filter { $0.observer != nil }
        }
    }
    
    fileprivate func removeDeadObserver() {
        // This force-unwrap is valid because we know that the now-nil observer will always be found because it will only ever be removed once when it is deinitializing:
        let observerIndex = observers.index(where: { $0.observer == nil })!
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
