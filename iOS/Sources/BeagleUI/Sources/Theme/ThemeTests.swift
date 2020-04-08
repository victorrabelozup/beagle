/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

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
    
    func test_textWithFontAndColor_shouldReturnAFunctionThatChangesFontAndColor() {
        // Given
        let font = UIFont.boldSystemFont(ofSize: 20)
        let color = UIColor.blue
        let view = UITextView()
        
        // When
        view |> BeagleStyle.text(font: font, color: color)
        
        // Then
        XCTAssertEqual(font, view.font)
        XCTAssertEqual(color, view.textColor)
    }
    
    func test_tabViewWithStyle_shouldReturnAFunctionThatChangesTabViewStyle() {
        // Given
        let backgroundColor: UIColor = .clear
        let indicatorColor: UIColor = .blue
        let tabItem = TabItem(title: "Tab 1", content: Text("Tab content"))
        let view = TabViewUIComponent(model: TabViewUIComponent.Model(tabIndex: 0, tabViewItems: [tabItem, tabItem]))
        
        // When
        view |> BeagleStyle.tabView(backgroundColor: backgroundColor, indicatorColor: indicatorColor)
        
        //Then
        XCTAssertEqual(backgroundColor, view.collectionView.backgroundColor)
        XCTAssertEqual(indicatorColor, view.containerIndicator.indicatorView.backgroundColor)
    }
}
