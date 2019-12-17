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
        let rendererProvider = WidgetRendererProviderSpy()
        let dependencies = RendererDependenciesContainer(
            rendererProvider: rendererProvider
        )

        let form = Form(action: "/singup", method: .post, child: WidgetDummy())
        guard let sut = try? FormWidgetViewRenderer(
            widget: form,
            dependencies: dependencies
        ) else {
            XCTFail("Could not create renderer.")
            return
        }
                
        // When
        let _ = sut.buildView(context: BeagleContextDummy())
        
        // Then
        XCTAssertEqual(rendererProvider.buildRendererCount, 1)
    }
    
    func test_buildView_shouldRegisterFormSubmit() {
        // Given
        let child = FlexWidget(children: [FormSubmit(child: Text("submit"))])
        let form = Form(action: "/singup", method: .post, child: child)

        guard let sut = try? FormWidgetViewRenderer(widget: form) else {
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

class BeagleContextSpy: BeagleContext {
    
    private(set) var didCallRegisterAction = false
    private(set) var didCallRegisterFormSubmit = false
    private(set) var didCallLazyLoad = false
    
    var screenController: UIViewController = UIViewController()
    
    func register(action: Action, inView view: UIView) {
        didCallRegisterAction = true
    }
    
    func register(form: Form, formView: UIView, submitView: UIView, validator: ValidatorProvider?) {
        didCallRegisterFormSubmit = true
    }
    
    func lazyLoad(url: String, initialState: UIView) {
        didCallLazyLoad = true
    }
}
