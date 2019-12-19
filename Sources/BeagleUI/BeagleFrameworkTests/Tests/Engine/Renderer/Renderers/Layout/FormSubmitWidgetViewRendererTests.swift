//
//  FormSubmitWidgetViewRendererTests.swift
//  BeagleFrameworkTests
//
//  Created by Lucas Araújo on 22/11/19.
//  Copyright © 2019 Zup IT. All rights reserved.
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
        let formSubmitView = sut.buildView(context: BeagleContextDummy())
        
        // Then
        XCTAssertEqual(rendererSpy.buildRendererCount, 1)
        XCTAssertTrue(formSubmitView.beagleFormElement is FormSubmit)
    }
}
