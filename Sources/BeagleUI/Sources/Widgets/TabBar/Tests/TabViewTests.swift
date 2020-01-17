//
//  Copyright © 26/11/19 Zup IT. All rights reserved.
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
            tabItem(index: 1, flex: Flex(alignContent: .center)),
            tabItem(index: 2, flex: Flex(justifyContent: .center, alignContent: .center))
        ])
        
        let screen = BeagleScreenViewController(
            viewModel: .init(screenType: .declarative(tabView))
        )
        assertSnapshotImage(screen)
    }
    
    func test_initWithSingleWidgetBuilder_shouldReturnExpectedInstance() {
        // Given / When
        let widget = TabView(tabItems: [
            tabItem(index: 1, flex: Flex(alignContent: .center))
        ])
        // Then
        XCTAssert(widget.tabItems.count > 0)
        XCTAssert(widget.tabItems[safe: 0]?.content is FlexWidget)
    }

    private func tabItem(index: Int, flex: Flex) -> TabItem {
        return TabItem(title: "Tab \(index)", content:
            FlexWidget(children: [
                Text("Text Tab \(index)"),
                Text("Text 2 Tab \(index)")
            ])
            .applyFlex(flex)
        )
    }
}
