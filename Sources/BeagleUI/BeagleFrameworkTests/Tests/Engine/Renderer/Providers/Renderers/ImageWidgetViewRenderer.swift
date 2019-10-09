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
    
    func test_whenTheWrongWidgetItsGivenToTheRendererInitializer() {
        //Given
        let widget: Widget
        
        //When
        
        widget = Button(text: "title")
        
        //Then
        do {
            let _ = try ImageWidgetViewRenderer(widget)
            XCTAssert(false, "Should have throwed invalidWidgetType")
        } catch {
            XCTAssert(true)
        }
    }
    
    func test_whenTheRightWidgetItsGivenToTheRendererInitializer() {
        //Given
        let widget: Widget
        
        //When
        
        widget = Image(path: "path")
        
        //Then
        do {
            let _ = try ImageWidgetViewRenderer(widget)
            XCTAssert(true)
        } catch {
            XCTAssert(false, "Invalid Data Type")
        }
    }
}

