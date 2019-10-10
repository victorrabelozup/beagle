//
//  ImageWidgetViewRenderer.swift
//  BeagleFrameworkTests
//
//  Created by Yan Dias on 09/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class ImageWidgetViewRendererTests: XCTestCase {
    
    // MARK: - Tests
    
    func test_onInitWithNoImageWidget_shouldReturnThrowError() {
        //Given
        let widget = Button(text: "title")

        // When / Then
        XCTAssertThrowsError(_ = try ImageWidgetViewRenderer(widget), "Expected error, but got nil.") { error in
            XCTAssertNotNil(error, "Expected error, but got \(error.localizedDescription)")
        }
    }
    
    func test_whenTheRightWidgetItsGivenToTheRendererInitializer() {
        //Given
        let widget = Image(path: "path")
        
        //When
        guard let imageWidgetRenderer = try? ImageWidgetViewRenderer(widget) else {
            XCTFail("Could not render TextField.")
            return
        }
        
        // Then
        XCTAssertTrue(imageWidgetRenderer.buildView() is UIImageView, "Expected a button type to be created.")
    }
}

