//
//  Copyright © 22/11/19 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class FormSubmitWidgetViewRendererTests: XCTestCase {
    
    func test_buildView_shouldReturnTheExpectedView() {
        // Given
        let rendererSpy = RendererProviderSpy()

        let dependencies = RendererDependenciesContainer(
            rendererProvider: rendererSpy
        )

        let formSubmit = FormSubmit(child: WidgetDummy())

        guard let sut = try? FormSubmitWidgetViewRenderer(
            widget: formSubmit,
            dependencies: dependencies
        ) else {
            XCTFail("Could not create renderer.")
            return
        }
                
        // When
        let view = sut.buildView(context: BeagleContextDummy())
        
        // Then
        XCTAssertEqual(rendererSpy.buildRendererCount, 1)
        XCTAssertTrue(view.beagleFormElement is FormSubmit)
    }
}
