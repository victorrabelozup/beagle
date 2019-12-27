//
//  ImageWidgetViewRendererTests.swift
//  BeagleFrameworkTests
//
//  Created by Yan Dias on 31/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class ImageWidgetViewRendererTests: XCTestCase {
    
    private let dependencies = RendererDependenciesContainer()
    
    func test_onInitWithNoButtonWidget_shouldThrowError() {
        //Given
        let widget = UnknownWidget()
        
        // When / Then
        XCTAssertThrowsError(_ = try ImageWidgetViewRenderer(
            widget: widget,
            dependencies: dependencies
        ))
    }
    
    func testContentMode() throws {
        //Given
        let expectedContentMode = UIImageView.ContentMode.scaleToFill
        let widget = Image(name: "teste", contentMode: .fitXY)
        
        //When
        let renderer = try ImageWidgetViewRenderer(widget: widget, dependencies: dependencies)
        
        guard let imageView = renderer.buildView(context: BeagleContextDummy()) as? UIImageView else {
            XCTFail("Build View not returning UIImageView")
            return
        }
        
        // Then
        XCTAssertEqual(expectedContentMode, imageView.contentMode)
    }
}

private struct UnknownWidget: Widget {}
