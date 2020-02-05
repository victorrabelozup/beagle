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
            viewModel: .init(screenType: .declarative(tabView.toScreen()))
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
        XCTAssert(widget.tabItems[safe: 0]?.content is Container)
    }
    
    func test_toView_shouldReturnTheExpectedView() {
        // Given
        let widget = TabView(tabItems: [
             TabItem(title: "Tab 1", content:
                 Container(children: [
                     Text("Blaaslkdjfaskldjfalskdjfasldjfasldfj"),
                     Text("Blaaslkdjfaskldjfalskdjfasldjfasldfj")
                 ])
                .applyFlex(Flex(alignContent: .center))
             ),
             TabItem(title: "Tab 2", content:
                 Container(children: [
                     Text("Text1 Tab 2"),
                     Text("Text2 Tab 2")
                 ])
                 .applyFlex(Flex(justifyContent: .flexEnd))
             )
        ])
        
        // When
        let resultingView = widget.toView(context: BeagleContextDummy(), dependencies: RendererDependenciesContainer())
        guard let tabViewUIComponent = resultingView as? TabViewUIComponent else {
            XCTFail("Expected `TabViewUIComponent`, but got \(String(describing: resultingView)).")
            return
        }
        
        let model = Mirror(reflecting: tabViewUIComponent).firstChild(of: TabViewUIComponent.Model.self)
        
        // Then
        XCTAssert(widget.tabItems == model?.tabViewItems)
    }

    private func tabItem(index: Int, flex: Flex) -> TabItem {
        return TabItem(title: "Tab \(index)", content:
            Container(children: [
                Text("Text Tab \(index)"),
                Text("Text 2 Tab \(index)")
            ])
            .applyFlex(flex)
        )
    }
}

extension TabItem: Equatable {
    public static func == (lhs: TabItem, rhs: TabItem) -> Bool {
        return lhs.title == rhs.title && lhs.icon == rhs.icon
    }
}
