//
//  Copyright © 26/11/19 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class TabViewRendererTests: XCTestCase {
    private let dependencies = RendererDependenciesContainer()
    
    func test_buildView_shouldReturnTheExpectedView() {
        // Given
        let widget = TabView(tabItems: [
             TabItem(title: "Tab 1", content:
                 FlexWidget(children: [
                     Text("Blaaslkdjfaskldjfalskdjfasldjfasldfj"),
                     Text("Blaaslkdjfaskldjfalskdjfasldjfasldfj")
                 ])
                .applyFlex(Flex(alignContent: .center))
             ),
             TabItem(title: "Tab 2", content:
                 FlexWidget(children: [
                     Text("Text1 Tab 2"),
                     Text("Text2 Tab 2")
                 ])
                 .applyFlex(Flex(justifyContent: .flexEnd))
             )
        ])
        guard let sut = try? TabViewRenderer(widget: widget, dependencies: dependencies) else {
            XCTFail("Could not create renderer for TabBar.")
            return
        }
        let context = BeagleContextDummy()
        
        // When
        let resultingView = sut.buildView(context: context)
        guard let tabViewUIComponent = resultingView as? TabViewUIComponent else {
            XCTFail("Expected `TabViewUIComponent`, but got \(String(describing: resultingView)).")
            return
        }
        
        let model = Mirror(reflecting: tabViewUIComponent).firstChild(of: TabViewUIComponent.Model.self)
        
        // Then
        XCTAssert(widget.tabItems == model?.tabViewItems)
    }

}

extension TabItem: Equatable {
    public static func == (lhs: TabItem, rhs: TabItem) -> Bool {
        return lhs.title == rhs.title && lhs.icon == rhs.icon
    }
}
