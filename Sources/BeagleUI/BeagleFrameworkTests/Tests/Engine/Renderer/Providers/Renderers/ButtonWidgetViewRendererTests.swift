//
//  ButtonWidgetViewRendererTests.swift
//  BeagleFrameworkTests
//
//  Created by Yan Dias on 08/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class ButtonWidgetViewRendererTests: XCTestCase {
    

    // MARK: - Tests
    
    func test_whenTheWrongWidgetItsGivenToTheRendererInitializer() {
        //Given
        let widget: Widget
        
        //When
        
        widget = Image(path: "path")
        
        //Then
        do {
            let _ = try ButtonWidgetViewRenderer(widget)
            XCTAssert(false, "Should have throwed invalidWidgetType")
        } catch {
            XCTAssert(true)
        }
    }
    
    func test_whenTheRightWidgetItsGivenToTheRendererInitializer() {
        //Given
        let widget: Widget
        
        //When
        
        widget = Button(text: "title")
        
        //Then
        do {
            let _ = try ButtonWidgetViewRenderer(widget)
            XCTAssert(true)
        } catch {
            XCTAssert(false, "Invalid Data Type")
        }
    }
    
    func test_buildViewButtonTitle() {
        //Given
        let widget: Widget
        let buttonTitle = "title"
        
        //When
        
        widget = Button(text: buttonTitle)
        
        //Then
        do {
            let viewRenderer = try ButtonWidgetViewRenderer(widget)
            let view = viewRenderer.buildView() as? UIButton
            XCTAssertEqual(view?.titleLabel?.text, buttonTitle)
        } catch {
            XCTAssert(false, "Invalid Data Type")
        }
    }
    
}

