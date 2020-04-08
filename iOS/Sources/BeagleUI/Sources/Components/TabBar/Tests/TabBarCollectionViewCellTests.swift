/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import XCTest
@testable import BeagleUI

final class TabBarCollectionViewCellTests: XCTestCase {
    
    func test_setupShouldSetTabItems() {
        // Given
        let sut = TabBarCollectionViewCell(frame: .zero)
        
        // When
        sut.setupTab(with: TabItem(icon: "icon", title: "Tab", content:
            Text("Text")
        ))
        
        let innerComponentView = Mirror(reflecting: sut).children.first
        
        // Then
        XCTAssert(innerComponentView?.value is UIStackView)
        XCTAssert(sut.contentView.subviews.count == 1)
    }
    
    func test_setupShouldSetTabItemsWithIconOnly() {
        // Given
        let sut = TabBarCollectionViewCell(frame: .zero)
        
        // When
        sut.setupTab(with: TabItem(icon: "icon", content:
            Text("Text")
        ))
        
        let innerComponentView = Mirror(reflecting: sut).children.first
        let stackView = innerComponentView?.value as? UIStackView
        
        // Then
        XCTAssertNotNil(stackView)
        XCTAssert(stackView?.subviews[0].isHidden == false)
        
    }
    
    func test_setupShouldSetTabItemsWithTitleOnly() {
        // Given
        let sut = TabBarCollectionViewCell(frame: .zero)
        
        // When
        sut.setupTab(with: TabItem(title: "Tab 1", content:
            Text("Text")
        ))
        
        let innerComponentView = Mirror(reflecting: sut).children.first
        let stackView = innerComponentView?.value as? UIStackView
        
        // Then
        XCTAssertNotNil(stackView)
        XCTAssert(stackView?.subviews[1].isHidden == false)
    }
    
}
