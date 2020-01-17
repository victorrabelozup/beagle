//
//  Copyright © 25/10/19 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class LayoutViewRendererProviderTests: XCTestCase {

    private let dependencies = RendererDependenciesContainer()

    private let provider = RendererProviding()

    func testFlexWidgetRenderer() {
        // Given
        let widget = FlexWidget(
            children: [Text("Oloquinho")],
            flex: Flex(direction: .ltr, flexDirection: .column)
        )

        // When
        let renderer = provider.buildRenderer(for: widget, dependencies: dependencies)
        // Then
        XCTAssert(renderer is FlexWidgetViewRenderer)
    }
    
    func testFlexSingleWidgetRenderer() {
        // Given
        let widget = FlexSingleWidget(
            child: Text("Meu"),
            flex: Flex(direction: .ltr, flexDirection: .column)
        )

        // When
        let renderer = provider.buildRenderer(for: widget, dependencies: dependencies)
        // Then
        XCTAssert(renderer is FlexSingleWidgetViewRenderer)
    }
    
    func testContainerRenderer() {
        // Given
        let widget = Container(
            header: Text("Tá pegando"),
            content: Text("Fogo"),
            footer: Text("Bixo")
        )

        // When
        let renderer = provider.buildRenderer(for: widget, dependencies: dependencies)
        // Then
        XCTAssert(renderer is ContainerWidgetViewRenderer)
    }
    
    func testSpacerRenderer() {
        // Given
        let widget = Spacer(100)
        // When
        let renderer = provider.buildRenderer(for: widget, dependencies: dependencies)
        // Then
        XCTAssert(renderer is SpacerWidgetViewRenderer)
    }
    
    func testListViewRenderer() {
        // Given
        let widget = ListView()

        // When
        let renderer = provider.buildRenderer(for: widget, dependencies: dependencies)
        // Then
        XCTAssert(renderer is ListViewWidgetRenderer)
    }
    
    func testNavigatorRenderer() {
        // Given
        let widget = Navigator(
            action: Navigate(type: .popView),
            child: Text("Navigation")
        )

        // When
        let renderer = provider.buildRenderer(for: widget, dependencies: dependencies)
        // Then
        XCTAssert(renderer is NavigatorWidgetViewRenderer)
    }

    func testScrollViewRenderer() {
        // Given
        let widget = ScrollView(children: [
            FlexWidget(children: [
                Text("Text")
            ])
        ])

        // When
        let renderer = provider.buildRenderer(for: widget, dependencies: dependencies)
        // Then
        XCTAssert(renderer is ScrollViewWidgetViewRenderer)
    }
    
    func testTabViewRenderer() {
        // Given
         let widget = TabView(tabItems: [
             TabItem(title: "Tab 1", content:
                 FlexWidget(children: [
                     Text("Blaaslkdjfaskldjfalskdjfasldjfasldfj")
                 ])
             )
        ])

        // When
        let renderer = provider.buildRenderer(for: widget, dependencies: dependencies)
        // Then
        XCTAssert(renderer is TabViewRenderer)
    }
    
    func testFormRenderer() {
        // Given
        let widget = Form(action: "Add", method: .post, child: Button(text: "Button Teste"))

        // When
        let renderer = provider.buildRenderer(for: widget, dependencies: dependencies)
        // Then
        XCTAssert(renderer is FormWidgetViewRenderer)
    }

    func testFormSubmitRenderer() {
        // Given
        let widget = FormSubmit(child: Button(text: "Teste 2"))

        // When
        let renderer = provider.buildRenderer(for: widget, dependencies: dependencies)
        // Then
        XCTAssert(renderer is FormSubmitWidgetViewRenderer)
    }

    func testFormInputRenderer() {
        // Given
        let widget = FormInput(name: "Input", child: Button(text: "Input Button"))

        // When
        let renderer = provider.buildRenderer(for: widget, dependencies: dependencies)
        // Then
        XCTAssert(renderer is FormInputWidgetViewRenderer)
    }
    
    func testLazyWidgetRenderer() {
        // Given
        let widget = LazyWidget(url: "", initialState: WidgetDummy())

        // When
        let renderer = provider.buildRenderer(for: widget, dependencies: dependencies)
        // Then
        XCTAssert(renderer is LazyWidgetViewRenderer)
    }
}
