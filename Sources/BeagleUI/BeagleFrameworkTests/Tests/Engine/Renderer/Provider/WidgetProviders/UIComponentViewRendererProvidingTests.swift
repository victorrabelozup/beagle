//
//  UIComponentViewRendererProvidingTests.swift
//  BeagleFrameworkTests
//
//  Created by Gabriela Coelho on 25/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class UIComponentViewRendererProvidingTests: XCTestCase {
    
    func test_whenButton_shouldReturnButtonWigetViewRenderer() {
        // Given
        let widget = Button(text: "Aoba")
        let renderer = WidgetRendererProviding()
        // When
        let buttonWidgetViewRenderer = renderer.buildRenderer(for: widget)
        // Then
        XCTAssert(buttonWidgetViewRenderer is ButtonWidgetViewRenderer, "Expected to build a button widget view renderer, but has built \(String(describing: type(of: buttonWidgetViewRenderer))).")
    }

    func test_whenText_shouldReturnImageWigetViewRenderer() {
        // Given
        let widget = Image(name: "image")
        let renderer = WidgetRendererProviding()
        // When
        let imageWidgetViewRenderer = renderer.buildRenderer(for: widget)
        // Then
        XCTAssert(imageWidgetViewRenderer is ImageWidgetViewRenderer, "Expected to build an image widget view renderer, but has built \(String(describing: type(of: imageWidgetViewRenderer))).")
    }
    
    func test_whenText_shouldReturnTextWigetViewRenderer() {
        // Given
        let widget = Text("aoba")
        let renderer = WidgetRendererProviding()
        // When
        let textWidgetViewRenderer = renderer.buildRenderer(for: widget)
        // Then
        XCTAssert(textWidgetViewRenderer is TextWidgetViewRenderer, "Expected to build a text widget view renderer, but has built \(String(describing: type(of: textWidgetViewRenderer))).")
    }

    func test_whenImage_shouldReturnImageWigetViewRenderer() {
        // Given
        let widget = Image(name: "teste")
        let renderer = WidgetRendererProviding()
        // When
        let imageWidgetViewRenderer = renderer.buildRenderer(for: widget)
        // Then
        XCTAssert(imageWidgetViewRenderer is ImageWidgetViewRenderer, "Expected to build a image widget view renderer, but has built \(String(describing: type(of: imageWidgetViewRenderer))).")
    }
    
    func test_whenNetworkImage_shouldReturnImageWigetViewRenderer() {
        // Given
        let widget = NetworkImage(url: "www.some.com")
        let renderer = WidgetRendererProviding()
        // When
        let networkImageWidgetViewRenderer = renderer.buildRenderer(for: widget)
        // Then
        XCTAssert(networkImageWidgetViewRenderer is NetworkImageWidgetViewRenderer, "Expected to build a network image widget view renderer, but has built \(String(describing: type(of: networkImageWidgetViewRenderer))).")
    }

}
