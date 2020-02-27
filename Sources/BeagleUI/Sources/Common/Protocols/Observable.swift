//
//  Copyright © 24/01/20 Zup IT. All rights reserved.
//

import Foundation

public struct WidgetState {
    public var value: Any?
    
    public init(value: Any?) {
        self.value = value
    }
}

public protocol WidgetStateObservable {
    var observable: Observable<WidgetState> { get }
}

public struct ObserverWrapper {
    weak var observer: Observer?
    
    init(_ observer: Observer) {
        self.observer = observer
    }
}

public protocol Observer: AnyObject {
    func didChangeValue(_ value: Any?)
}

public protocol ObservableProtocol: AnyObject {
    var observers: [ObserverWrapper] { get set }
    
    func addObserver(_ observer: Observer)
    func deleteObserver(_ observer: Observer)
    func notifyObservers()
}

public class Observable<T>: ObservableProtocol {
    public var observers: [ObserverWrapper] = []

    public var value: T {
        didSet {
            notifyObservers()
        }
    }
    
    public init(value: T) {
        self.value = value
    }

    deinit {
        observers.removeAll()
    }
    
    public func addObserver(_ observer: Observer) {
        guard self.observers.contains(where: { $0.observer === observer }) == false else {
            return
        }
        observers.append(ObserverWrapper(observer))
    }
    
    public func deleteObserver(_ observer: Observer) {
        guard let index = self.observers.firstIndex(where: { $0.observer === observer }) else {
            return
        }
        observers.remove(at: index)
    }

    public func notifyObservers() {
        for observer in observers {
            observer.observer?.didChangeValue(value)
        }
    }
}
