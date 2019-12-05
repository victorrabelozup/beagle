//
//  ActionExecutorTests.swift
//  BeagleFrameworkTests
//
//  Created by Lucas Araújo on 22/11/19.
//  Copyright © 2019 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class ActionExecutorTests: XCTestCase {
    
    func test_whenExecuteNavigateAction_shouldUseTheNavigator() {
        // Given
        let navigationSpy = BeagleNavigationSpy()
        let sut = ActionExecuting(
            navigator: navigationSpy,
            customActionHandler: CustomActionHandlerDummy())
        let action = Navigate(type: .addView)
        
        // When
        sut.doAction(action, sender: self, context: BeagleContextDummy())
        
        // Then
        XCTAssertTrue(navigationSpy.didCallNavigate)
    }
    
    func test_whenExecuteFormValidation_shouldCallErrorListener() {
        // Given
        let sut = ActionExecuting(customActionHandler: CustomActionHandlerDummy())
        let inputName = "inputName"
        let errorMessage = "Error Message"
        let fieldError = FieldError(inputName: inputName, message: errorMessage)
        let action = FormValidation(errors: [fieldError])
        
        let formInput = FormInput(name: inputName, child: WidgetDummy())
        let validationErrorListenerSpy = ValidationErrorListenerSpy()
        validationErrorListenerSpy.beagleFormElement = formInput
        let form = Form(action: "action", method: .post, child: FlexSingleWidget(child: formInput))
        let formView = UIView()
        formView.addSubview(validationErrorListenerSpy)
        let sender = SubmitFormGestureRecognizer(form: form, formView: formView, validator: nil)
        
        // When
        sut.doAction(action, sender: sender, context: BeagleContextDummy())
        
        // Then
        XCTAssertEqual(validationErrorListenerSpy.validationErrorMessage, errorMessage)
    }
    
    func test_whenShowNativeDialog_shouldPresentAlertController() {
        // Given
        let sut = ActionExecuting(customActionHandler: CustomActionHandlerDummy())
        let action = ShowNativeDialog(
            title: "Title",
            message: "Message",
            buttonText: "Button")
        let context = BeagleContextStub()
        let viewControllerSpy = UINavigationControllerSpy()
        context.screenController = viewControllerSpy
        
        // When
        sut.doAction(action, sender: self, context: context)
        
        // Then
        XCTAssertTrue(viewControllerSpy.presentViewControllerCalled)
    }
    
    func test_whenExecuteCustomAction_shouldUseActionHandler() {
        // Given
        let customActionHandlerSpy = CustomActionHandlerSpy()
        let sut = ActionExecuting(customActionHandler: customActionHandlerSpy)
        let action = CustomAction(name: "custom-action", data: [:])
        
        // When
        sut.doAction(action, sender: self, context: BeagleContextDummy())
        
        // Then
        XCTAssertEqual(customActionHandlerSpy.actionsHandledCount, 1)
    }
}

// MARK: - Test helpers

class CustomActionHandlerDummy: CustomActionHandler {
    func handle(context: BeagleContext, action: CustomAction) {
    }
}

class BeagleNavigationSpy: BeagleNavigation {
    private(set) var didCallNavigate = false
    func navigate(action: Navigate, source: UIViewController, animated: Bool) {
        didCallNavigate = true
    }
}

class CustomActionHandlerSpy: CustomActionHandler {
    private(set) var actionsHandledCount = 0
    func handle(context: BeagleContext, action: CustomAction) {
        actionsHandledCount += 1
    }
}

class ValidationErrorListenerSpy: UIView, ValidationErrorListener {
    private(set) var validationErrorMessage: String?
    func onValidationError(message: String?) {
        validationErrorMessage = message
    }
}

class BeagleContextStub: BeagleContext {
    var screenController: UIViewController = UIViewController()
    func register(action: Action, inView view: UIView) {
    }
    func register(form: Form, formView: UIView, submitView: UIView, validator: ValidatorHandler?) {
    }
    func lazyLoad(url: URL, initialState: UIView) {
    }
}
