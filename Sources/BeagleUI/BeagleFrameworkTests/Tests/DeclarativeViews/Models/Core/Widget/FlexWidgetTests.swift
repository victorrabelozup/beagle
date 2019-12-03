//
//  FlexWidgetTests.swift
//  BeagleFrameworkTests
//
//  Created by Gabriela Coelho on 02/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class FlexWidgetTests: XCTestCase {
    
    func test_initWithChildren_shouldReturnFlexWidgetAndSetDependenciesProperly() {
        // Given
        let sut = FlexWidget(children: [
            Text("Some texts."),
            Text("More texts.")
        ], flex: Flex())
        
        let mirror = Mirror(reflecting: sut)
        // When
        let flex = mirror.firstChild(of: Flex.self)
        let widget = mirror.firstChild(of: [Widget].self)
        // Then
        XCTAssertTrue(sut.children.count > 1, "Expected flex widget to have children.")
        XCTAssertNotNil(flex, "Expected a valid instance of type `Flex`, but got nil.")
        XCTAssertNotNil(widget, "Expected a valid instance of type `Widget`, but got nil.")
        
    }
    
    func test_initWithOnlyOneChild_shouldReturnFlexWidgetAndSetDependenciesProperly() {
        // Given
        let sut = FlexWidget(children: [Text("Some text.")], flex: Flex())
        let mirror = Mirror(reflecting: sut)
        
        // When
        let flex = mirror.firstChild(of: Flex.self)
        let widget = mirror.firstChild(of: [Widget].self)
        
        // Then
        XCTAssertTrue(sut.children.count == 1, "Expected flex widget to have one child.")
        XCTAssertNotNil(flex, "Expected a valid instance of type `Flex`, but got nil.")
        XCTAssertNotNil(widget, "Expected a valid instance of type `Widget`, but got nil.")
    }
    
    func test_initWidgetArrayBuilder_shouldReturnFlexWidget() {
        // Given / When
        let flexWidget = FlexWidget {
            Text("Some texts")
            Text("More texts")
        }
        // Then
        XCTAssertTrue(flexWidget.children.count > 1, "Expected flex widget to have children.")
    }
    
    func test_applyFlex_shouldReturnFlexWidget() {
        // Given
        let widget = FlexWidget {
            Text("Some texts")
        }
        // When
        let flexWidget = widget.applyFlex(Flex(justifyContent: .center))
        // Then
        XCTAssertNotNil(flexWidget.flex, "Expected to have a flex type, but got none.")
    }
    
    func test_onNewClosure_shouldInstantiateChild() {
        // Given / When
        let widget = FlexWidget.new { () -> Widget in
            return Text("Some text")
        }
        // Then
        XCTAssert(widget.children.count == 1, "Expected flex widget to have created only one child, but it has \(widget.children.count).")
        XCTAssert(widget.children.first is Text, "Expected child to be a Text, but it is \(String(describing: type(of: widget.children.first))).")
    }
    
    func test_onNewClosure_shouldInstantiateChildren() {
        // Given / When
        let widget = FlexWidget.new { () -> [Widget] in
            return [Text("One text"), Text("Two texts"), Button(text: "One button")]
        }
        // Then
        XCTAssert(widget.children.count > 1, "Expected flex widget to have created more than one child, but it has \(widget.children.count).")
        XCTAssert(widget.children.last is Button, "Expected last child to be a Button, but it is \(String(describing: type(of: widget.children.last))).")
    }
}
