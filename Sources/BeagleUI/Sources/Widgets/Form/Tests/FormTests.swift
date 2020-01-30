//
//  FormTests.swift
//  BeagleFrameworkTests
//
//  Created by Eduardo Sanches Bocato on 14/11/19.
//  Copyright © 2019 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class FormTests: XCTestCase {
    
    func test_initWithChild_shouldReturnValidForm() {
        // Given / When
        let sut = Form(action: "action", method: .get, child:
            Text("Teste")
        )
        // Then
        XCTAssertTrue(sut.child is Text)
    }
    
    func test_buildView_shouldRegisterFormSubmit() throws {
        // Given
        let child = FlexWidget(children: [FormSubmit(child: Text("submit"))])
        let form = Form(action: "/singup", method: .post, child: child)
        let context = BeagleContextSpy()
                
        // When
        _ = form.toView(context: context, dependencies: RendererDependenciesContainer())
        
        // Then
        XCTAssertTrue(context.didCallRegisterFormSubmit)
    }
}

class BeagleContextSpy: BeagleContext {
    
    private(set) var didCallRegisterAction = false
    private(set) var didCallRegisterFormSubmit = false
    private(set) var didCallLazyLoad = false
    private(set) var didCallDoAction = false
    
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
    
    func doAction(_ action: Action, sender: Any) {
        didCallDoAction = true
    }
}
