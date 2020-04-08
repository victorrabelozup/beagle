/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import Foundation

public protocol Observer: AnyObject {
    func didChangeValue(_ value: Any?)
}

public protocol ObservableProtocol: AnyObject {
    associatedtype Value

    var observers: [Observer] { get }

    func addObserver(_ observer: Observer)
    func deleteObserver(_ observer: Observer)

    var value: Value { get set }
}

public class Observable<T>: ObservableProtocol {

    public var observers: [Observer] {
        return _observers.compactMap { $0.observer }
    }

    private var _observers: [WeakObserver] = []

    public var value: T {
        didSet { notifyObservers() }
    }
    
    public init(value: T) {
        self.value = value
    }

    deinit {
        _observers.removeAll()
    }
    
    public func addObserver(_ observer: Observer) {
        guard !isAlreadyObserving(observer) else { return }

        _observers.append(WeakObserver(observer))
    }
    
    public func deleteObserver(_ observer: Observer) {
        guard let index = self._observers.firstIndex(where: { $0.observer === observer }) else {
            return
        }
        _observers.remove(at: index)
    }

    private func notifyObservers() {
        for observer in _observers {
            observer.observer?.didChangeValue(value)
        }
    }

    private func isAlreadyObserving(_ observer: Observer) -> Bool {
        return _observers.contains { $0.observer === observer }
    }
}

private struct WeakObserver {
    weak var observer: Observer?

    init(_ observer: Observer) {
        self.observer = observer
    }
}
