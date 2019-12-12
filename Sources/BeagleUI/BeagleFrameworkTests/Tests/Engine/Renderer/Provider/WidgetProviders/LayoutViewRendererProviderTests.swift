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

    private let dependencies = RendererDependenciesContainer()

    func test_whenFlexWidget_shouldReturnFlexWidgetViewRenderer() {
        // Given
        let widget = FlexWidget(
            children: [Text("Oloquinho")],
            flex: Flex(direction: .ltr, flexDirection: .column)
        )
        let provider = WidgetRendererProviding()
        // When
        let flexRenderer = provider.buildRenderer(for: widget, dependencies: dependencies)
        // Then
        XCTAssert(flexRenderer is FlexWidgetViewRenderer, "Expected to build a flex widget view renderer, but has built \(String(describing: type(of: flexRenderer))).")
    }
    
    func test_whenFlexSingleWidget_shouldReturnFlexSingleWidgetViewRenderer() {
        // Given
        let widget = FlexSingleWidget(
            child: Text("Meu"),
            flex: Flex(direction: .ltr, flexDirection: .column)
        )
        let provider = WidgetRendererProviding()
        // When
        let flexRenderer = provider.buildRenderer(for: widget, dependencies: dependencies)
        // Then
        XCTAssert(flexRenderer is FlexSingleWidgetViewRenderer, "Expected to build a flex single widget view renderer, but has built \(String(describing: type(of: flexRenderer))).")
    }
    
    func test_whenContainer_shouldReturnContainerWidgetViewRenderer() {
        // Given
        let widget = Container(header: Text("Tá pegando"), content: Text("Fogo"), footer: Text("Bixo"))
        let provider = WidgetRendererProviding()
        // When
        let containerRenderer = provider.buildRenderer(for: widget, dependencies: dependencies)
        // Then
        XCTAssert(containerRenderer is ContainerWidgetViewRenderer, "Expected to build a container widget view renderer, but has built \(String(describing: type(of: containerRenderer))).")
    }
    
    func test_whenSpacer_shouldReturnSpacerWidgetViewRenderer() {
        // Given
        let widget = Spacer(100)
        let renderer = WidgetRendererProviding()
        // When
        let spaceRenderer = renderer.buildRenderer(for: widget, dependencies: dependencies)
        // Then
        XCTAssert(spaceRenderer is SpacerWidgetViewRenderer, "Expected to build a spacer widget view renderer, but has built \(String(describing: type(of: spaceRenderer))).")
    }
    
    func test_whenListView_shouldReturnListViewWidgetViewRenderer() {
        // Given
        let widget = ListView()
        let provider = WidgetRendererProviding()
        // When
        let listRenderer = provider.buildRenderer(for: widget, dependencies: dependencies)
        // Then
        XCTAssert(listRenderer is ListViewWidgetRenderer, "Expected to build a listview widget view renderer, but has built \(String(describing: type(of: listRenderer))).")
    }
    
    func test_whenNavigator_shouldReturnNavigatorWidgetViewRenderer() {
        // Given
        let widget = Navigator(
            action: Navigate(type: .popView),
            child: Text("Navigation")
        )
        let provider = WidgetRendererProviding()
        // When
        let navigationRenderer = provider.buildRenderer(for: widget, dependencies: dependencies)
        // Then
        XCTAssert(navigationRenderer is NavigatorWidgetViewRenderer, "Expected to build a navigator widget view renderer, but has built \(String(describing: type(of: navigationRenderer))).")
    }

    func test_whenScrollView_shouldReturnScrollViewWidgetViewRenderer() {
        // Given
        let widget = ScrollView {
            FlexWidget {
                Text("Text")
            }
        }
        let provider = WidgetRendererProviding()
        // When
        let scrollRenderer = provider.buildRenderer(for: widget, dependencies: dependencies)
        // Then
        XCTAssert(scrollRenderer is ScrollViewWidgetViewRenderer, "Expected to build a container widget view renderer, but has built \(String(describing: type(of: scrollRenderer))).")
    }
    
    func test_whenForm_shouldReturnFormViewRenderer() {
        // Given
        let widget = Form(action: "", method: .get, child: WidgetDummy())
        let renderer = WidgetRendererProviding()
        // When
        let flexRenderer = renderer.buildRenderer(for: widget, dependencies: dependencies)
        // Then
        XCTAssert(flexRenderer is FormWidgetViewRenderer)
    }
    
    func test_whenFormInput_shouldReturnFormInputViewRenderer() {
        // Given
        let widget = FormInput(name: "name", child: WidgetDummy())
        let provider = WidgetRendererProviding()
        // When
        let formInputRenderer = provider.buildRenderer(for: widget, dependencies: dependencies)
        // Then
        XCTAssert(formInputRenderer is FormInputWidgetViewRenderer)
    }
    
    func test_whenFormSubmit_shouldReturnFormSubmitViewRenderer() {
        // Given
        let widget = FormSubmit(child: WidgetDummy())
        let provider = WidgetRendererProviding()
        // When
        let formSubmitRenderer = provider.buildRenderer(for: widget, dependencies: dependencies)
        // Then
        XCTAssert(formSubmitRenderer is FormSubmitWidgetViewRenderer)
    }
    
    func test_whenLazyWidget_shouldReturnLazyWidgetViewRenderer() {
        // Given
        let widget = LazyWidget(url: "", initialState: WidgetDummy())
        let provider = WidgetRendererProviding()
        // When
        let lazyRenderer = provider.buildRenderer(for: widget, dependencies: dependencies)
        // Then
        XCTAssert(lazyRenderer is LazyWidgetViewRenderer)
    }
}


