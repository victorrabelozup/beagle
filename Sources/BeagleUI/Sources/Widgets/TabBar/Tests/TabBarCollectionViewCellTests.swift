//
//  TabBarCollectionViewCellTests.swift
//  BeagleFrameworkTests
//
//  Created by Gabriela Coelho on 29/11/19.
//  Copyright © 2019 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class TabBarCollectionViewCellTests: XCTestCase {
    
    func test_setupShouldSetTabItems() {
        // Given
        let sut = TabBarCollectionViewCell(frame: .zero)
        
        // When
        sut.setupTab(with: TabItem(icon: "icon", title: "Tab") {
            Text("Text")
        })
        
        let innerWidgetView = Mirror(reflecting: sut).children.first
        
        // Then
        XCTAssertTrue(innerWidgetView?.value is UIStackView, "Inner property value should be UIStackView.")
        XCTAssertEqual(sut.contentView.subviews.count, 1, "`contentView` should have `1` subviews, a UIStackView.")
    }
    
    func test_setupShouldSetTabItemsWithIconOnly() {
        // Given
        let sut = TabBarCollectionViewCell(frame: .zero)
        
        // When
        sut.setupTab(with: TabItem(icon: "icon") {
            Text("Text")
        })
        
        let innerWidgetView = Mirror(reflecting: sut).children.first
        let stackView = innerWidgetView?.value as? UIStackView
        
        // Then
        XCTAssertNotNil(stackView, "StackView should not be nil. ")
        XCTAssertTrue(stackView?.subviews[0].isHidden == false, "ImageView from stackView should not be hidden.")
        
    }
    
    func test_setupShouldSetTabItemsWithTitleOnly() {
        // Given
        let sut = TabBarCollectionViewCell(frame: .zero)
        
        // When
        sut.setupTab(with: TabItem(title: "Tab 1") {
            Text("Text")
        })
        
        let innerWidgetView = Mirror(reflecting: sut).children.first
        let stackView = innerWidgetView?.value as? UIStackView
        
        // Then
        XCTAssertNotNil(stackView, "StackView should not be nil. ")
        XCTAssertTrue(stackView?.subviews[1].isHidden == false, "UILabel from stackView should not be hidden.")
    }
    
}
