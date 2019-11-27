//
//  FormWidgetViewRendererTests.swift
//  BeagleFrameworkTests
//
//  Created by Lucas Araújo on 22/11/19.
//  Copyright © 2019 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class FormWidgetViewRendererTests: XCTestCase {
    
    func test_buildView_shouldReturnTheExpectedView() {
        // Given
        let widgetRendererProvider = WidgetRendererProviderSpy()
        let flexConfigurator = FlexViewConfiguratorDummy()
        let applicationTheme = AppThemeDummy()
        let form = Form(action: "/singup", method: .post, child: WidgetDummy())
        guard let sut = try? FormWidgetViewRenderer(
            widget: form,
            rendererProvider: widgetRendererProvider,
            flexViewConfigurator: flexConfigurator,
            applicationTheme: applicationTheme
        ) else {
            XCTFail("Could not create renderer.")
            return
        }
        let context = BeagleContextDummy()
                
        // When
        let _ = sut.buildView(context: context)
        
        // Then
        XCTAssertEqual(widgetRendererProvider.buildRendererCount, 1)
    }
    
    func test_buildView_shouldRegisterFormSubmit() {
        // Given
        let widgetRendererProvider = FormSubmitWidgetRendererProviderMock()
        let flexConfigurator = FlexViewConfiguratorDummy()
        let applicationTheme = AppThemeDummy()
        let child = FlexWidget(children: [FormSubmit(child: Text("submit"))])
        let form = Form(action: "/singup", method: .post, child: child)
        guard let sut = try? FormWidgetViewRenderer(
            widget: form,
            rendererProvider: widgetRendererProvider,
            flexViewConfigurator: flexConfigurator,
            applicationTheme: applicationTheme
        ) else {
            XCTFail("Could not create renderer.")
            return
        }
        let context = BeagleContextSpy()
                
        // When
        let _ = sut.buildView(context: context)
        
        // Then
        XCTAssertTrue(context.didCallRegisterFormSubmit)
    }
}

class FormSubmitWidgetRendererProviderMock: WidgetRendererProvider {
    func buildRenderer(for widget: Widget) -> WidgetViewRendererProtocol {
        return FormSubmitWidgetViewRendererMock(widget)
    }
}

class FormSubmitWidgetViewRendererMock: WidgetViewRendererProtocol {
    required init(_ widget: Widget) {
    }
    func buildView(context: BeagleContext) -> UIView {
        let formView = UIView()
        let submitView = UIView()
        formView.addSubview(submitView)
        submitView.beagleFormElement = FormSubmit(child: WidgetDummy())
        return formView
    }
}

class BeagleContextSpy: BeagleContext {
    
    private(set) var didCallRegisterAction = false
    private(set) var didCallRegisterFormSubmit = false
    
    var screenController: UIViewController = UIViewController()
    
    func register(action: Action, inView view: UIView) {
        didCallRegisterAction = true
    }
    
    func register(form: Form, formView: UIView, submitView: UIView, validator: ValidatorHandler?) {
        didCallRegisterFormSubmit = true
    }
}
