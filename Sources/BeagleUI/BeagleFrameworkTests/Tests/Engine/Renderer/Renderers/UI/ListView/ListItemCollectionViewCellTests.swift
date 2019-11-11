//
//  ListItemCollectionViewCellTests.swift
//  BeagleFrameworkTests
//
//  Created by Eduardo Sanches Bocato on 07/11/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class ListItemCollectionViewCellTests: XCTestCase {
    
    func test_setupShouldAddWidgetView() {
        // Given
        let widgetView = UIView()
        widgetView.tag = 123
        let cellFrame = CGRect(x: 0, y: 1, width: 2, height: 3)
        
        let sut = ListItemCollectionViewCell(frame: cellFrame)
        
        // When
        sut.setup(with: widgetView)
        let innerWidgetView = Mirror(reflecting: sut).children.first(where: { $0.label == "widgetView" } )?.value as? UIView
        
        // Then
        XCTAssertNotNil(innerWidgetView, "Inner property `widgetView` should not be nil.")
        XCTAssertEqual(sut.contentView.frame, innerWidgetView?.frame, "Expected \(String(describing: sut.contentView.frame)), but got \(cellFrame).")
        XCTAssertEqual(sut.contentView.subviews.count, 1, "`contentView` should have `1` subview.")
        XCTAssertNotNil(sut.contentView.viewWithTag(widgetView.tag), "`contentView` should contain the `widgetView`.")
    }
    
    func test_prepareForReuse_shouldCancelHTTPRequest_andRemoveWidgetView() {
        // Given
        let widgetWithRequestViewSpy = WidgetWithRequestViewSpy()
        widgetWithRequestViewSpy.tag = 123
        let sut = ListItemCollectionViewCell()
        sut.setup(with: widgetWithRequestViewSpy)
        
        // When
        sut.prepareForReuse()
        let innerWidgetView = Mirror(reflecting: sut).children.first(where: { $0.label == "widgetView" } )?.value as? UIView
        
        // Then
        XCTAssertTrue(widgetWithRequestViewSpy.cancelHTTPRequestCalled, "`cancelHTTPRequest` should have been called.")
        XCTAssertEqual(sut.contentView.subviews.count, 0, "`contentView` should have no subviews.")
        XCTAssertNil(sut.contentView.viewWithTag(widgetWithRequestViewSpy.tag), "`contentView` should not contain the `widgetView`.")
        XCTAssertNil(innerWidgetView, "The inner property `widgetView` should be nil.")
    }
    
}

// MARK: - Testing Helpers

private class WidgetWithRequestViewSpy: UIView, HTTPRequestCanceling {
    
    private(set) var cancelHTTPRequestCalled = false
    func cancelHTTPRequest() {
        cancelHTTPRequestCalled = true
    }
    
}
