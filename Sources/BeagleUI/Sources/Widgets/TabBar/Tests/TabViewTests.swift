//
//  TabViewTests.swift
//  BeagleFrameworkTests
//
//  Created by Gabriela Coelho on 26/11/19.
//  Copyright © 2019 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI
import SnapshotTesting

final class TabViewTests: XCTestCase {
    
    func test_whenDecodingJson_thenItShouldReturnATabView() throws {
        let widget: TabView = try widgetFromJsonFile(fileName: "TabView")
        assertSnapshot(matching: widget, as: .dump)
    }
    
    func test_viewWithTabView() {
        let tabView = TabView(tabItems: [
            TabItem(title: "Tab 1") {
                FlexWidget {
                    Text("Text Tab 1")
                    Text("Text 2 Tab 1")
                }.applyFlex(Flex(alignContent: .center))
            },
            TabItem(title: "Tab 2") {
                FlexWidget {
                    Text("Text Tab 2")
                    Text("Text 2 Tab 2")
                }.applyFlex(Flex(justifyContent: .center, alignContent: .center))
            }
        ])
        
        let screen = BeagleScreenViewController(
            viewModel: .init(screenType: .declarative(tabView))
        )
        assertSnapshot(matching: screen, as: .image)
    }
    
    func test_initWithSingleWidgetBuilder_shouldReturnExpectedInstance() {
        // Given / When
        let widget = TabView(tabItems: [
            TabItem(title: "Tab 1") {
                FlexWidget {
                    Text("Text Tab 1")
                    Text("Text 2 Tab 1")
                }.applyFlex(Flex(alignContent: .center))
            }
        ])
        // Then
        XCTAssert(widget.tabItems.count > 0, "Expected `widget.tabItems` to be have tabItems.")
        XCTAssert(widget.tabItems[safe: 0]?.content is FlexWidget, "Expected tabItem to be flexWidget, but it is \(type(of: widget.tabItems[safe: 0]?.content)).")
        
    }
}
