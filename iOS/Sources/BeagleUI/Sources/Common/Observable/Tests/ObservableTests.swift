/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import XCTest
@testable import BeagleUI
import SnapshotTesting

final class ObservableTests: XCTestCase {
    
    func test_whenChangedValue_shouldNotifyObservers() {
        // Given
        let observableDummy = DummyObservable()
        let observer = DummyObserver()
        observableDummy.observable.addObserver(observer)
        
        // When
        observableDummy.changeValue()
        // Then
        XCTAssert(observableDummy.observable.observers.count > 0)
        XCTAssert(observer.didCallDidChangeValueFunction)
    }
        
    func test_whenObservable_shouldRemoveObserverToObservable() {
        // Given
        let observableDummy = DummyObservable()
        let observer0 = DummyObserver()
        let observer1 = DummyObserver()
        observableDummy.observable.addObserver(observer0)
        observableDummy.observable.addObserver(observer1)
        
        // When
        observableDummy.observable.deleteObserver(observer0)
        // Then
        XCTAssert(observableDummy.observable.observers.count == 1)
    }

    func test_whenObserverNotOnList_shouldNotRemove() {
        // Given
        let observableDummy = DummyObservable()
        let observer = DummyObserver()
        let observerNotOnList = DummyObserver()

        observableDummy.observable.addObserver(observer)
        observableDummy.observable.deleteObserver(observerNotOnList)
        
        // Then
        XCTAssert(observableDummy.observable.observers.count == 1)
    }

}

private struct DummyObservable: WidgetStateObservable {
    var observable = Observable<WidgetState>(value: WidgetState(value: false))
    
    func changeValue() {
        observable.value = WidgetState(value: true)
    }
}

private class DummyObserver: Observer {
    var didCallDidChangeValueFunction = false
    
    func didChangeValue(_ value: Any?) {
        didCallDidChangeValueFunction = true
    }
}
