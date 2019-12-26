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
        let provider = RendererProviding()
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
        let provider = RendererProviding()
        // When
        let flexRenderer = provider.buildRenderer(for: widget, dependencies: dependencies)
        // Then
        XCTAssert(flexRenderer is FlexSingleWidgetViewRenderer, "Expected to build a flex single widget view renderer, but has built \(String(describing: type(of: flexRenderer))).")
    }
    
    func test_whenContainer_shouldReturnContainerWidgetViewRenderer() {
        // Given
        let widget = Container(header: Text("Tá pegando"), content: Text("Fogo"), footer: Text("Bixo"))
        let provider = RendererProviding()
        // When
        let containerRenderer = provider.buildRenderer(for: widget, dependencies: dependencies)
        // Then
        XCTAssert(containerRenderer is ContainerWidgetViewRenderer, "Expected to build a container widget view renderer, but has built \(String(describing: type(of: containerRenderer))).")
    }
    
    func test_whenSpacer_shouldReturnSpacerWidgetViewRenderer() {
        // Given
        let widget = Spacer(100)
        let renderer = RendererProviding()
        // When
        let spaceRenderer = renderer.buildRenderer(for: widget, dependencies: dependencies)
        // Then
        XCTAssert(spaceRenderer is SpacerWidgetViewRenderer, "Expected to build a spacer widget view renderer, but has built \(String(describing: type(of: spaceRenderer))).")
    }
    
    func test_whenListView_shouldReturnListViewWidgetViewRenderer() {
        // Given
        let widget = ListView()
        let provider = RendererProviding()
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
        let provider = RendererProviding()
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
        let provider = RendererProviding()
        // When
        let scrollWidgetViewRenderer = provider.buildRenderer(for: widget, dependencies: dependencies)
        // Then
        XCTAssert(scrollWidgetViewRenderer is ScrollViewWidgetViewRenderer, "Expected to build a scroll widget view renderer, but has built \(String(describing: type(of: scrollWidgetViewRenderer))).")
    }
    
    func test_whenTabBar_shouldReturnTabBarWidgetViewRenderer() {
        // Given
         let widget = TabView(tabItems: [
             TabItem(title: "Tab 1") {
                 FlexWidget {
                     Text("Blaaslkdjfaskldjfalskdjfasldjfasldfj")
                     Text("Blaaslkdjfaskldjfalskdjfasldjfasldfj")

                 }.applyFlex(Flex(alignContent: .center))
             },
             TabItem(title: "Tab 2") {
                 FlexWidget {
                     Text("Text1 Tab 2")
                     Text("Text2 Tab 2")
                 }.applyFlex(Flex(justifyContent: .flexEnd))
             }
         ])
        let renderer = RendererProviding()
        // When
        let tabBarWidgetViewRenderer = renderer.buildRenderer(for: widget, dependencies: dependencies)
        // Then
        XCTAssert(tabBarWidgetViewRenderer is TabViewRenderer, "Expected to build a tabBar widget view renderer, but has built \(String(describing: type(of: tabBarWidgetViewRenderer))).")
    }
    
    func test_whenForm_shouldReturnFormWidgetViewRenderer() {
        // Given
        let widget = Form(action: "Add", method: .post, child: Button(text: "Button Teste"))
        let renderer = RendererProviding()
        // When
        let formWidgetViewRenderer = renderer.buildRenderer(for: widget, dependencies: dependencies)
        // Then
        XCTAssert(formWidgetViewRenderer is FormWidgetViewRenderer, "Expected to build a form widget view renderer, but has built \(String(describing: type(of: formWidgetViewRenderer))).")
    }

    func test_whenFormSubmit_shouldReturnFormSubmitWidgetViewRenderer() {
        // Given
        let widget = FormSubmit(child: Button(text: "Teste 2"))
        let renderer = RendererProviding()
        // When
        let formSubmitWidgetViewRenderer = renderer.buildRenderer(for: widget, dependencies: dependencies)
        // Then
        XCTAssert(formSubmitWidgetViewRenderer is FormSubmitWidgetViewRenderer, "Expected to build a form submit widget view renderer, but has built \(String(describing: type(of: formSubmitWidgetViewRenderer))).")
    }

    func test_whenFormInput_shouldReturnFormInputWidgetViewRenderer() {
        // Given
        let widget = FormInput(name: "Input", child: Button(text: "Input Button"))
        let renderer = RendererProviding()
        // When
        let formInputWidgetViewRenderer = renderer.buildRenderer(for: widget, dependencies: dependencies)
        // Then
        XCTAssert(formInputWidgetViewRenderer is FormInputWidgetViewRenderer, "Expected to build a form input widget view renderer, but has built \(String(describing: type(of: formInputWidgetViewRenderer))).")

    }
    
    func test_whenForm_shouldReturnFormViewRenderer() {
        // Given
        let widget = Form(action: "", method: .get, child: WidgetDummy())
        let renderer = RendererProviding()
        // When
        let flexRenderer = renderer.buildRenderer(for: widget, dependencies: dependencies)
        // Then
        XCTAssert(flexRenderer is FormWidgetViewRenderer)
    }
    
    func test_whenFormInput_shouldReturnFormInputViewRenderer() {
        // Given
        let widget = FormInput(name: "name", child: WidgetDummy())
        let provider = RendererProviding()
        // When
        let formInputRenderer = provider.buildRenderer(for: widget, dependencies: dependencies)
        // Then
        XCTAssert(formInputRenderer is FormInputWidgetViewRenderer)
    }
    
    func test_whenFormSubmit_shouldReturnFormSubmitViewRenderer() {
        // Given
        let widget = FormSubmit(child: WidgetDummy())
        let provider = RendererProviding()
        // When
        let formSubmitRenderer = provider.buildRenderer(for: widget, dependencies: dependencies)
        // Then
        XCTAssert(formSubmitRenderer is FormSubmitWidgetViewRenderer)
    }
    
    func test_whenLazyWidget_shouldReturnLazyWidgetViewRenderer() {
        // Given
        let widget = LazyWidget(url: "", initialState: WidgetDummy())
        let provider = RendererProviding()
        // When
        let lazyRenderer = provider.buildRenderer(for: widget, dependencies: dependencies)
        // Then
        XCTAssert(lazyRenderer is LazyWidgetViewRenderer)
    }
}
