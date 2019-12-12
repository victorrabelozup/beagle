//
//  FormInputWidgetViewRendererTests.swift
//  BeagleFrameworkTests
//
//  Created by Lucas Araújo on 22/11/19.
//  Copyright © 2019 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class FormInputWidgetViewRendererTests: XCTestCase {
    
    func test_buildView_shouldReturnTheExpectedView() {
        // Given
        let rendererProviderSpy = WidgetRendererProviderSpy()
        let dependencies = RendererDependenciesContainer(
            rendererProvider: rendererProviderSpy
        )

        let formInput = FormInput(name: "username", child: WidgetDummy())
        guard let sut = try? FormInputWidgetViewRenderer(
            widget: formInput,
            dependencies: dependencies
        ) else {
            XCTFail("Could not create renderer.")
            return
        }
                
        // When
        let formInputView = sut.buildView(context: BeagleContextDummy())
        
        // Then
        XCTAssertEqual(rendererProviderSpy.buildRendererCount, 1)
        XCTAssertTrue(formInputView.beagleFormElement is FormInput)
    }
}
