//
//  Copyright © 29/11/19 Zup IT. All rights reserved.
//

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
        
        let innerWidgetView = Mirror(reflecting: sut).children.first
        
        // Then
        XCTAssert(innerWidgetView?.value is UIStackView)
        XCTAssert(sut.contentView.subviews.count == 1)
    }
    
    func test_setupShouldSetTabItemsWithIconOnly() {
        // Given
        let sut = TabBarCollectionViewCell(frame: .zero)
        
        // When
        sut.setupTab(with: TabItem(icon: "icon", content:
            Text("Text")
        ))
        
        let innerWidgetView = Mirror(reflecting: sut).children.first
        let stackView = innerWidgetView?.value as? UIStackView
        
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
        
        let innerWidgetView = Mirror(reflecting: sut).children.first
        let stackView = innerWidgetView?.value as? UIStackView
        
        // Then
        XCTAssertNotNil(stackView)
        XCTAssert(stackView?.subviews[1].isHidden == false)
    }
    
}
