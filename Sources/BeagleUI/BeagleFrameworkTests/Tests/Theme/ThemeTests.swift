//
//  ThemeTests.swift
//  BeagleFrameworkTests
//
//  Created by Daniel Tes on 13/11/19.
//  Copyright © 2019 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class ThemeTests: XCTestCase {
    
    func test_applyStyle() {
        // Given
        let view = UIView()
        let style: () -> (UIView?) -> Void = { { $0?.backgroundColor = .red } }
        let sut = AppTheme(styles: ["styleId": style])
        
        // When
        sut.applyStyle(for: view, withId: "styleId")
        
        // Then
        XCTAssertEqual(.red, view.backgroundColor)
    }
    
    func test_backgroundColor_shouldReturnAFunctionThatChangesBackgroundColor() {
        // Given
        let view = UIView()
        
        // When
        view |> BeagleStyle.backgroundColor(withColor: .red)
        
        // Then
        XCTAssertEqual(.red, view.backgroundColor)
    }
    
    func test_labelWithFont_shouldReturnAFunctionThatChangesFont() {
        // Given
        let view = UILabel()
        
        // When
        view |> BeagleStyle.label(withFont: .italicSystemFont(ofSize: 8))
        
        // Then
        XCTAssertEqual(.italicSystemFont(ofSize: 8), view.font)
    }
    
    func test_labelWithTextColor_shouldReturnAFunctionThatChangesTextColor() {
        // Given
        let view = UILabel()
        
        // When
        view |> BeagleStyle.label(withTextColor: .red)
        
        // Then
        XCTAssertEqual(.red, view.textColor)
    }
    
    func test_labelWithFontAndTextColor_shouldReturnAFunctionThatChangesFontAndTextColor() {
        // Given
        let view = UILabel()
        
        // When
        view |> BeagleStyle.label(font: .italicSystemFont(ofSize: 8), color: .red)
        
        // Then
        XCTAssertEqual(.italicSystemFont(ofSize: 8), view.font)
        XCTAssertEqual(.red, view.textColor)
    }
    
    func test_buttonWithTitleColor_shouldReturnAFunctionThatChangesButtonTitleColorForNormalState() {
        // Given
        let view = UIButton()
        
        // When
        view |> BeagleStyle.button(withTitleColor: .red)
        
        // Then
        XCTAssertEqual(.red, view.titleColor(for: .normal))
    }
}
