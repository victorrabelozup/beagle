/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import XCTest
import SnapshotTesting
@testable import BeagleUI

final class TextTests: XCTestCase {
    
    private lazy var theme = AppTheme(styles: [
        "test.text.style": textStyle
    ])
    
    private func textStyle() -> (UITextView?) -> Void {
        return BeagleStyle.text(font: .boldSystemFont(ofSize: 20), color: .blue)
            <> BeagleStyle.backgroundColor(withColor: .black)
    }

    private lazy var dependencies = BeagleScreenDependencies(
        theme: theme
    )
    
    func testEqualTextContent() throws {
        // Given
        let component = Text("Test")
        let context = BeagleContextDummy()
        
        // When
        guard let label = component.toView(context: context, dependencies: dependencies) as? UITextView else {
            XCTFail("Unable to type cast to UITextView.")
            return
        }
        
        // Then
        XCTAssertEqual(component.text, label.text)
    }
    
    func testTextWithRightAlignment() throws {
        // Given
        let component = Text("Test")
        let context = BeagleContextDummy()
        
        // When
        guard let label = component.toView(context: context, dependencies: dependencies) as? UITextView else {
            XCTFail("Unable to type cast to UITextView.")
            return
        }
        
        // Then
        XCTAssertEqual(label.textAlignment, NSTextAlignment.natural)
    }
    
    func testTextWithLeftAlignment() throws {
        // Given
        let component = Text("Test", alignment: .left)
        let context = BeagleContextDummy()
        
        // When
        guard let label = component.toView(context: context, dependencies: dependencies) as? UITextView else {
            XCTFail("Unable to type cast to UITextView.")
            return
        }
        
        // Then
        XCTAssertEqual(label.textAlignment, NSTextAlignment.left)
    }
    
    func test_whenDecodingJson_shouldReturnAText() throws {
        let component: Text = try componentFromJsonFile(fileName: "TextComponent")
        assertSnapshot(matching: component, as: .dump)
    }
    
    func test_renderTextComponent() throws {
        let component: Text = try componentFromJsonFile(fileName: "TextComponent")
        let view = component.toView(context: BeagleContextDummy(), dependencies: dependencies)
        assertSnapshotImage(view, size: CGSize(width: 300, height: 150))
    }

}
