//
//  Copyright © 17/10/19 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class FlexWidgetViewRendererTests: XCTestCase {
    
    func test_buildView_shouldReturnTheExpectedView() throws {
        //Given
        let flexSpy = FlexViewConfiguratorSpy()
        let dependencies = RendererDependenciesContainer(flex: flexSpy)

        let numberOfChilds = 3
        let flexWidgetChilds = Array(repeating: WidgetDummy(), count: numberOfChilds)
        let flexWidget = FlexWidget(children: flexWidgetChilds)

        let renderer = try FlexWidgetViewRenderer(
            widget: flexWidget,
            dependencies: dependencies
        )
        let context = BeagleContextDummy()
        
        // When
        let resultingView = renderer.buildView(context: context)
        
        //Then
        XCTAssertTrue(flexSpy.setupFlexCalled)
        XCTAssertEqual(resultingView, flexSpy.viewPassedToSetupFlex)
        XCTAssertEqual(flexWidget.flex.size?.height, flexSpy.flexPassed?.size?.height)
        XCTAssertEqual(flexWidget.flex.size?.width, flexSpy.flexPassed?.size?.width)
        XCTAssertEqual(resultingView.subviews.count, numberOfChilds)
    }
}
