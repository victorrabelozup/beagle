/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import XCTest
import SnapshotTesting
@testable import BeagleUI

final class ScrollViewTests: XCTestCase {

    func test_initWithChildBuilder_shouldReturnExpectedInstance() {
        // Given / When
        let component = ScrollView(children: [
            Text("text")
        ])
        
        // Then
        XCTAssert(component.children.count == 1)
        XCTAssert(component.children[safe: 0] is Text)
    }
    
    func test_initWithChildrenBuilder_shouldReturnExpectedInstance() {
        // Given / When
        let component = ScrollView(children: [
            Text("text"),
            Button(text: "text")
        ])
        
        // Then
        XCTAssert(component.children.count == 2)
        XCTAssert(component.children[safe: 0] is Text)
        XCTAssert(component.children[safe: 1] is Button)
    }
    
    func test_toView_shouldReturnTheExpectedView() {
        // Given
        let dependencies = BeagleScreenDependencies()
        
        let container = ScrollView(children: [
            ComponentDummy()
        ])

        // When
        let resultingView = container.toView(context: BeagleContextDummy(), dependencies: dependencies)
        
        // Then
        XCTAssert(resultingView.subviews.count == 1)
    }
    
    func test_whenLayoutSubViewsIsCalledOnBagleContainerScrollView_itShouldSetupTheContentSizeCorrectly() {
        // Given
        let subview = UIView(frame: .init(x: 0, y: 0, width: 100, height: 100))
        let sut = BeagleContainerScrollView()
        sut.addSubview(subview)

        // When
        sut.layoutSubviews()

        // Then
        XCTAssert(subview.frame.size == sut.contentSize)
        
    }
    
    func test_whenDecodingJson_shouldReturnAScrollView() throws {
        let component: ScrollView = try componentFromJsonFile(fileName: "ScrollViewComponent")
        assertSnapshot(matching: component, as: .dump)
    }
    
    func test_renderScrollView() throws {
        let component: ScrollView = try componentFromJsonFile(fileName: "ScrollViewComponent")
        let screen = Beagle.screen(.declarative(component.toScreen()))
        assertSnapshotImage(screen)
    }

    func test_renderHorizontalScrollView() throws {
        let component: ScrollView = try componentFromJsonFile(fileName: "HorizontalScrollView")
        let screen = Beagle.screen(.declarative(component.toScreen()))
        assertSnapshotImage(screen, size: CGSize(width: 300, height: 30))
    }

}
