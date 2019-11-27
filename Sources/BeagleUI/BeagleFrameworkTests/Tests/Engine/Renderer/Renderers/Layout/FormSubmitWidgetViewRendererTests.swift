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
        let widgetRendererProvider = WidgetRendererProviderSpy()
        let flexConfigurator = FlexViewConfiguratorDummy()
        let applicationTheme = AppThemeDummy()
        let formSubmit = FormSubmit(child: WidgetDummy())
        guard let sut = try? FormSubmitWidgetViewRenderer(
            widget: formSubmit,
            rendererProvider: widgetRendererProvider,
            flexViewConfigurator: flexConfigurator,
            applicationTheme: applicationTheme
        ) else {
            XCTFail("Could not create renderer.")
            return
        }
        let context = BeagleContextDummy()
                
        // When
        let formSubmitView = sut.buildView(context: context)
        
        // Then
        XCTAssertEqual(widgetRendererProvider.buildRendererCount, 1)
        XCTAssertTrue(formSubmitView.beagleFormElement is FormSubmit)
    }
}
