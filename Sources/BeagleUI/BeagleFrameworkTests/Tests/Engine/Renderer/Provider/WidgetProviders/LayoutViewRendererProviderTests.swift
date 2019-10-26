//
//  LayoutViewRendererProviderTests.swift
//  BeagleFrameworkTests
//
//  Created by Gabriela Coelho on 25/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class LayoutViewRendererProviderTests: XCTestCase {
    
    func test_whenFlexWidget_shouldReturnFlexWidgetViewRenderer() {
        // Given
        let widget = FlexWidget(children: [Text("Oloquinho")],
                                flex: Flex(direction: .ltr, flexDirection: .column))
        let renderer = WidgetRendererProviding()
        // When
        let flexWidgetViewRenderer = renderer.buildRenderer(for: widget)
        // Then
        XCTAssert(flexWidgetViewRenderer is FlexWidgetViewRenderer, "Expected to build a flex widget view renderer, but has built \(String(describing: type(of: flexWidgetViewRenderer))).")
    }
    
    func test_whenFlexSingleWidget_shouldReturnFlexSingleWidgetViewRenderer() {
        // Given
        let widget = FlexSingleWidget(child: Text("Meu"),
                                      flex: Flex(direction: .ltr, flexDirection: .column))
        let renderer = WidgetRendererProviding()
        // When
        let flexSingleWidgetViewRenderer = renderer.buildRenderer(for: widget)
        // Then
        XCTAssert(flexSingleWidgetViewRenderer is FlexSingleWidgetViewRenderer, "Expected to build a flex single widget view renderer, but has built \(String(describing: type(of: flexSingleWidgetViewRenderer))).")
    }
    
    func test_whenContainer_shouldReturnContainerWidgetViewRenderer() {
        // Given
        let widget = Container(header: Text("Tá pegando"), content: Text("Fogo"), footer: Text("Bixo"))
        let renderer = WidgetRendererProviding()
        // When
        let containerWidgetViewRenderer = renderer.buildRenderer(for: widget)
        // Then
        XCTAssert(containerWidgetViewRenderer is ContainerWidgetViewRenderer, "Expected to build a container widget view renderer, but has built \(String(describing: type(of: containerWidgetViewRenderer))).")
    }
    
    func test_whenSpacer_shouldReturnSpacerWidgetViewRenderer() {
        // Given
        let widget = Spacer(100)
        let renderer = WidgetRendererProviding()
        // When
        let spacerWidgetViewRenderer = renderer.buildRenderer(for: widget)
        // Then
        XCTAssert(spacerWidgetViewRenderer is SpacerWidgetViewRenderer, "Expected to build a spacer widget view renderer, but has built \(String(describing: type(of: spacerWidgetViewRenderer))).")
    }
}


