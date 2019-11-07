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
    
    // MARK: - Tests
    
    func test_onInitWithNoButtonWidget_shouldThrowError() {
        //Given
        let widget = UnknownWidget()
        
        // When / Then
        XCTAssertThrowsError(_ = try ImageWidgetViewRenderer(widget), "Expected error, but got nil.")
    }
    
    func test_onInitWithImageWidget_shouldSetRightContentMode() {
        //Given
        let imageName = "teste"
        let expectedContentMode: UIImageView.ContentMode = .scaleToFill
        let widget = Image(name: imageName, contentMode: .fitXY)
        
        //When
        guard let imageWidgetRenderer = try? ImageWidgetViewRenderer(widget) else {
            XCTFail("Could not create ImageWidgetViewRenderer.")
            return
        }
        
        guard let imageView = imageWidgetRenderer.buildView() as? UIImageView else {
            XCTFail("Build View not returning UIImageView")
            return
        }
        
        // Then
        XCTAssertEqual(expectedContentMode, imageView.contentMode, "Expected '\(String(describing: expectedContentMode))', but got '\(String(describing: imageView.contentMode))'")
    }
}

private struct UnknownWidget: NativeWidget { }
