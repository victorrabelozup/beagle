//
//  BeagleContextTests.swift
//  BeagleFrameworkTests
//
//  Created by Lucas Araújo on 13/11/19.
//  Copyright © 2019 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI

final class BeagleContextTests: XCTestCase {
    
    func test_screenController_shouldBeBeagleScreenViewController() {
        // Given
        let widget = ServerDrivenWidgetMock()
        let sut: BeagleContext = BeagleScreenViewController(
            screenType: .declarative(widget.content),
            flexConfigurator: FlexViewConfiguratorDummy(),
            viewBuilder: BeagleViewBuilderDummy(),
            serverDrivenScreenLoader: ServerDrivenScreenLoaderDummy(),
            actionExecutor: ActionExecutorDummy()
        )
        
        // Then
        XCTAssertTrue(sut.screenController is BeagleScreenViewController)
    }

    func test_registerAction_shouldAddGestureRecognizer() {
        // Given
        let widget = ServerDrivenWidgetMock()
        let sut = BeagleScreenViewController(
            screenType: .declarative(widget.content),
            flexConfigurator: FlexViewConfiguratorDummy(),
            viewBuilder: BeagleViewBuilderDummy(),
            serverDrivenScreenLoader: ServerDrivenScreenLoaderDummy(),
            actionExecutor: ActionExecutorDummy()
        )
        let view = UILabel()
        let action = Navigate(type: .popView)
        
        // When
        sut.register(action: action, inView: view)
        
        // Then
        XCTAssertEqual(1, view.gestureRecognizers?.count)
        XCTAssertTrue(view.isUserInteractionEnabled)
    }
    
    func test_action_shouldBeTriggered() {
        // Given
        let widget = ServerDrivenWidgetMock()
        let actionExecutorSpy = ActionExecutorSpy()
        let controller = BeagleScreenViewController(
            screenType: .declarative(widget.content),
            flexConfigurator: FlexViewConfiguratorDummy(),
            viewBuilder: BeagleViewBuilderDummy(),
            serverDrivenScreenLoader: ServerDrivenScreenLoaderDummy(),
            actionExecutor: actionExecutorSpy
        )
        
        let navigationController = UINavigationController(rootViewController: controller)
        guard let sut = navigationController.viewControllers.first as? BeagleScreenViewController else {
            XCTFail("Could not find `BeagleScreenViewController`.")
            return
        }
        
        let view = UILabel()
        let action = Navigate(type: .popView)
        sut.register(action: action, inView: view)
        
        guard let actionGestureRecognizer = view.gestureRecognizers?.first as? ActionGestureRecognizer else {
            XCTFail("Could not find `ActionGestureRecognizer`.")
            return
        }
        
        // When
        sut.handleActionGesture(actionGestureRecognizer)
                
        // Then
        XCTAssertTrue(actionExecutorSpy.didCallDoAction)
    }
    
    func test_registerForm_shouldAddGestureRecognizer() {
        // Given
        let widget = ServerDrivenWidgetMock()
        let sut = BeagleScreenViewController(
            screenType: .declarative(widget.content),
            flexConfigurator: FlexViewConfiguratorDummy(),
            viewBuilder: BeagleViewBuilderDummy(),
            serverDrivenScreenLoader: ServerDrivenScreenLoaderDummy(),
            actionExecutor: ActionExecutorDummy()
        )
        let form = Form(action: "action", method: .put, child: WidgetDummy())
        let formView = UIView()
        let submitView = UILabel()
        
        // When
        sut.register(form: form, formView: formView, submitView: submitView, validator: nil)
        
        // Then
        XCTAssertEqual(1, submitView.gestureRecognizers?.count)
        XCTAssertTrue(submitView.isUserInteractionEnabled)
    }
    
    func test_formSubmit_shouldValidateInputs() {
        // Given
        let widget = ServerDrivenWidgetMock()
        let actionExecutorSpy = ActionExecutorSpy()
        let sut = BeagleScreenViewController(
            screenType: .declarative(widget.content),
            flexConfigurator: FlexViewConfiguratorDummy(),
            viewBuilder: BeagleViewBuilderDummy(),
            serverDrivenScreenLoader: ServerDrivenScreenLoaderDummy(),
            actionExecutor: actionExecutorSpy
        )
        
        let form = Form(action: "submit", method: .post, child: WidgetDummy())
        let validInput = FormInput(name: "name", required: true, validator: "valid", child: WidgetDummy())
        let invalidInput = FormInput(name: "document", required: true, validator: "invalid", child: WidgetDummy())
        let optionalInput = FormInput(name: "birthdate", child: WidgetDummy())
        let invalidValidatorInput = FormInput(name: "country", required: true, validator: "XYZ", child: WidgetDummy())
        let validInputView = FormInputViewStub(validInput)
        let invalidInputView = FormInputViewStub(invalidInput)
        let optionalInputView = FormInputViewStub(optionalInput)
        let invalidValidatorInputView = FormInputViewStub(invalidValidatorInput)
        let otherView = UIView()
        otherView.beagleFormElement = FormInput(name: "other", child: WidgetDummy())
        let formView = UIView()
        formView.addSubview(validInputView)
        formView.addSubview(invalidInputView)
        formView.addSubview(optionalInputView)
        formView.addSubview(invalidValidatorInputView)
        formView.addSubview(otherView)
        let validator = ValidatorHandling()
        var validationCount = 0
        validator["valid"] = { _ in
            validationCount += 1
            return true
        }
        validator["invalid"] = { _ in
            validationCount += 1
            return false
        }
        
        sut.register(form: form, formView: formView, submitView: formView, validator: validator)
        guard let gesture = formView.gestureRecognizers?.first as? SubmitFormGestureRecognizer else {
            XCTFail("Could not find `SubmitFormGestureRecognizer`.")
            return
        }
        
        // When
        sut.handleSubmitFormGesture(gesture)
                
        // Then
        XCTAssertEqual(validationCount, 2)
    }
    
    func test_formSubmit_shouldExecuteResponseAction() {
        // Given
        let widget = ServerDrivenWidgetMock()
        let actionExecutorSpy = ActionExecutorSpy()
        let serverDrivenStub = ServerDrivenScreenLoaderStub(
            submitFormResult: .success(CustomAction(name: "custom", data: [:]))
        )
        let sut = BeagleScreenViewController(
            screenType: .declarative(widget.content),
            flexConfigurator: FlexViewConfiguratorDummy(),
            viewBuilder: BeagleViewBuilderDummy(),
            serverDrivenScreenLoader: serverDrivenStub,
            actionExecutor: actionExecutorSpy
        )
        
        let form = Form(action: "submit", method: .post, child: WidgetDummy())
        let validInput = FormInput(name: "name", child: WidgetDummy())
        let validInputView = FormInputViewStub(validInput, value: "John Doe")
        let formView = UIView()
        formView.addSubview(validInputView)
        
        sut.register(form: form, formView: formView, submitView: formView, validator: nil)
        guard let gesture = formView.gestureRecognizers?.first as? SubmitFormGestureRecognizer else {
            XCTFail("Could not find `SubmitFormGestureRecognizer`.")
            return
        }
        
        // When
        sut.handleSubmitFormGesture(gesture)
                
        // Then
        XCTAssertTrue(actionExecutorSpy.didCallDoAction)
    }
    
    func test_formSubmitError_shouldNotExecuteAction() {
        // Given
        let widget = ServerDrivenWidgetMock()
        let actionExecutorSpy = ActionExecutorSpy()
        let serverDrivenStub = ServerDrivenScreenLoaderStub(
            submitFormResult: .failure(.invalidEntity)
        )
        let sut = BeagleScreenViewController(
            screenType: .declarative(widget.content),
            flexConfigurator: FlexViewConfiguratorDummy(),
            viewBuilder: BeagleViewBuilderDummy(),
            serverDrivenScreenLoader: serverDrivenStub,
            actionExecutor: actionExecutorSpy
        )
        
        let form = Form(action: "delete", method: .delete, child: WidgetDummy())
        let formView = UIView()
        
        sut.register(form: form, formView: formView, submitView: formView, validator: nil)
        guard let gesture = formView.gestureRecognizers?.first as? SubmitFormGestureRecognizer else {
            XCTFail("Could not find `SubmitFormGestureRecognizer`.")
            return
        }
        
        // When
        sut.handleSubmitFormGesture(gesture)
                
        // Then
        XCTAssertFalse(actionExecutorSpy.didCallDoAction)
    }
    
    func test_lazyLoad_shouldReplaceTheInitialContent() {
        // Given
        let initialView = UIView()
        let lazyContent = UILabel()
        let viewBuilder = BeagleViewBuilderSpy()
        viewBuilder.viewToReturn = lazyContent
        let screenLoader = ServerDrivenScreenLoaderStub(loadWidgetResult: .success(WidgetDummy()))
        let sut = BeagleScreenViewController(
            screenType: .declarative(WidgetDummy()),
            flexConfigurator: FlexViewConfiguratorDummy(),
            viewBuilder: viewBuilder,
            serverDrivenScreenLoader: screenLoader,
            actionExecutor: ActionExecutorDummy()
        )
        sut.view.addSubview(initialView)
        
        guard let url = URL(string: "URL") else {
            XCTFail("Could not create URL")
            return
        }
        
        // When
        sut.lazyLoad(url: url, initialState: initialView)
        
        // Then
        XCTAssertNil(initialView.superview, "`initialView` should be removed from view hierarchy")
        XCTAssertTrue(lazyContent.superview === sut.view)
    }
    
    func test_lazyLoad_withUpdatableView_shouldCallUpdate() {
        // Given
        let initialView = OnStateUpdatableViewSpy()
        initialView.yoga.isEnabled = true
        let screenLoader = ServerDrivenScreenLoaderStub(loadWidgetResult: .success(WidgetDummy()))
        let sut = BeagleScreenViewController(
            screenType: .declarative(WidgetDummy()),
            flexConfigurator: FlexViewConfiguratorDummy(),
            viewBuilder: BeagleViewBuilderDummy(),
            serverDrivenScreenLoader: screenLoader,
            actionExecutor: ActionExecutorDummy()
        )
        sut.view.addSubview(initialView)
        
        guard let url = URL(string: "URL") else {
            XCTFail("Could not create URL")
            return
        }
        
        // When
        sut.lazyLoad(url: url, initialState: initialView)
        
        // Then
        XCTAssertNotNil(initialView.superview, "`initialView` should not be removed from view hierarchy")
        XCTAssertTrue(initialView.didCallOnUpdateState)
    }
}

// MARK: - Testing Helpers

class UINavigationControllerSpy: UINavigationController {
    private(set) var popViewControllerCalled = false
    private(set) var presentViewControllerCalled = false
    private(set) var dismissViewControllerCalled = false

    override func popViewController(animated: Bool) -> UIViewController? {
        popViewControllerCalled = true
        return super.popViewController(animated: animated)
    }
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        presentViewControllerCalled = true
        super.present(viewControllerToPresent, animated: flag, completion: completion)
    }
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        dismissViewControllerCalled = true
        super.dismiss(animated: flag, completion: completion)
    }
}

class FormInputViewStub: UIView, InputValue, ValidationErrorListener {
    let value: String
    init(_ formInput: FormInput, value: String = "") {
        self.value = value
        super.init(frame: .zero)
        self.beagleFormElement = formInput
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func getValue() -> Any {
        return value
    }
    func onValidationError(message: String?) {
    }
}

class OnStateUpdatableViewSpy: UIView, OnStateUpdatable {
    private(set) var didCallOnUpdateState = false
    func onUpdateState(widget: Widget) -> Bool {
        didCallOnUpdateState = true
        return true
    }
}
