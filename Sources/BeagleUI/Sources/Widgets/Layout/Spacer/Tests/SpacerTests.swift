//
//  Copyright © 29/01/20 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class SpacerTests: XCTestCase {
    
    func test_toView_shouldReturnTheExpectedView() {
        // Given
        let flexConfiguratorSpy = FlexViewConfiguratorSpy()
        let dependencies = RendererDependenciesContainer(
            flex: flexConfiguratorSpy
        )
        let spacer = Spacer(1.0)
    
        // When
        let resultingView = spacer.toView(context: BeagleContextDummy(), dependencies: dependencies)
    
        // Then
        XCTAssertTrue(flexConfiguratorSpy.setupFlexCalled, "Expected to call `applyFlex`.")
        XCTAssertEqual(spacer.size, flexConfiguratorSpy.flexPassed?.size?.width?.value, "Expected \(spacer.size), but got \(String(describing: flexConfiguratorSpy.flexPassed?.size?.width?.value)).")
        XCTAssertEqual(spacer.size, flexConfiguratorSpy.flexPassed?.size?.height?.value, "Expected \(spacer.size), but got \(String(describing: flexConfiguratorSpy.flexPassed?.size?.height?.value)).")
        XCTAssertEqual(resultingView, flexConfiguratorSpy.viewPassedToSetupFlex, "Expected \(String(describing: resultingView)), but got \(String(describing: flexConfiguratorSpy.viewPassedToSetupFlex)).")
    }
}
