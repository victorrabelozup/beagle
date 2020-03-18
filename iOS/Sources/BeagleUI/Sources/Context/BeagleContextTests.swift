//
//  BeagleContextTests.swift
//  BeagleFrameworkTests
//
//  Created by Lucas Araújo on 13/11/19.
//  Copyright © 2019 Zup IT. All rights reserved.
//

import XCTest
@testable import BeagleUI
import SnapshotTesting

final class BeagleContextTests: XCTestCase {
    
    func test_screenController_shouldBeBeagleScreenViewController() {
        // Given
        let component = SimpleComponent()
        let sut: BeagleContext = BeagleScreenViewController(viewModel: .init(
            screenType: .declarative(component.content.toScreen()),
            dependencies: BeagleScreenDependencies()
        ))
        
        // Then
        XCTAssertTrue(sut.screenController is BeagleScreenViewController)
    }

    func test_registerAction_shouldAddGestureRecognizer() {
        // Given
        let component = SimpleComponent()
        let sut = BeagleScreenViewController(viewModel: .init(
            screenType: .declarative(component.content.toScreen()),
            dependencies: BeagleScreenDependencies()
        ))
        let view = UILabel()
        let action = Navigate.popView
        
        // When
        sut.register(action: action, inView: view)
        
        // Then
        XCTAssertEqual(1, view.gestureRecognizers?.count)
        XCTAssertTrue(view.isUserInteractionEnabled)
    }
    
    func test_action_shouldBeTriggered() {
        // Given
        let component = SimpleComponent()
        let actionExecutorSpy = ActionExecutorSpy()

        let controller = BeagleScreenViewController(viewModel: .init(
            screenType: .declarative(component.content.toScreen()),
            dependencies: BeagleScreenDependencies(
                actionExecutor: actionExecutorSpy
            )
        ))
        
        let navigationController = UINavigationController(rootViewController: controller)
        guard let sut = navigationController.viewControllers.first as? BeagleScreenViewController else {
            XCTFail("Could not find `BeagleScreenViewController`.")
            return
        }
        
        let view = UILabel()
        let action = Navigate.popView
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
        let component = SimpleComponent()
        let sut = BeagleScreenViewController(viewModel: .init(
            screenType: .declarative(component.content.toScreen()),
            dependencies: BeagleScreenDependencies()
        ))
        let form = Form(path: "path", method: .put, child: ComponentDummy())
        let formView = UIView()
        let submitView = UILabel()
        
        // When
        sut.register(form: form, formView: formView, submitView: submitView, validatorHandler: nil)
        
        // Then
        XCTAssertEqual(1, submitView.gestureRecognizers?.count)
        XCTAssertTrue(submitView.isUserInteractionEnabled)
    }
    
    func test_formSubmit_shouldValidateInputs() {
        // Given
        let component = SimpleComponent()
        let sut = BeagleScreenViewController(viewModel: .init(
            screenType: .declarative(component.content.toScreen()),
            dependencies: BeagleScreenDependencies()
        ))
        
        let form = Form(path: "submit", method: .post, child: ComponentDummy())

        let otherView = UIView()
        otherView.beagleFormElement = FormInput(
            name: "other", child: ComponentDummy()
        )

        let valid = FormInputViewStub(FormInput(
            name: "name", required: true, validator: "valid", child: ComponentDummy()
        ))
        let invalid = FormInputViewStub(FormInput(
            name: "document", required: true, validator: "invalid", child: ComponentDummy()
        ))
        let optional = FormInputViewStub(FormInput(
            name: "birthdate", child: ComponentDummy()
        ))
        let invalidValidator = FormInputViewStub(FormInput(
            name: "country", required: true, validator: "XYZ", child: ComponentDummy()
        ))

        let formSubmit = FormSubmit(child: Button(text: "Add"), enabled: true)
        let formSubmitView = FormSubmitViewStub(formSubmit)

        let formView = UIView()
        formView.addSubview(valid)
        formView.addSubview(invalid)
        formView.addSubview(optional)
        formView.addSubview(invalidValidator)
        formView.addSubview(otherView)
        formView.addSubview(formSubmitView)

        let validator = ValidatorProviding()
        var validationCount = 0
        validator["valid"] = { _ in
            validationCount += 1
            return true
        }
        validator["invalid"] = { _ in
            validationCount += 1
            return false
        }
    
        sut.register(form: form, formView: formView, submitView: formSubmitView, validatorHandler: validator)
        guard let gesture = formSubmitView.gestureRecognizers?.first as? SubmitFormGestureRecognizer else {
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
        let component = SimpleComponent()
        let actionExecutorSpy = ActionExecutorSpy()
        let networkStub = NetworkStub(
            formResult: .success(CustomAction(name: "custom", data: [:]))
        )

        let sut = BeagleScreenViewController(viewModel: .init(
            screenType: .declarative(component.content.toScreen()),
            dependencies: BeagleScreenDependencies(
                actionExecutor: actionExecutorSpy,
                network: networkStub
            )
        ))
        
        let form = Form(path: "submit", method: .post, child: ComponentDummy())
        let validInput = FormInput(name: "name", child: ComponentDummy())
        let formSubmit = FormSubmit(child: Button(text: "Add"), enabled: true)
        let validInputView = FormInputViewStub(validInput, value: "John Doe")
        let formSubmitView = FormSubmitViewStub(formSubmit)
        let formView = UIView()
        formView.addSubview(validInputView)
        formView.addSubview(formSubmitView)
        
        sut.register(form: form, formView: formView, submitView: formSubmitView, validatorHandler: nil)
        guard let gesture = formSubmitView.gestureRecognizers?.first as? SubmitFormGestureRecognizer else {
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
        let component = SimpleComponent()
        let actionExecutorSpy = ActionExecutorSpy()
        let networkStub = NetworkStub(
            formResult: .failure(.networkError(NSError()))
        )
        let sut = BeagleScreenViewController(viewModel: .init(
            screenType: .declarative(component.content.toScreen()),
            dependencies: BeagleScreenDependencies(
                actionExecutor: actionExecutorSpy,
                network: networkStub
            )
        ))
        
        let form = Form(path: "delete", method: .delete, child: ComponentDummy())
        let formView = UIView()
        
        sut.register(form: form, formView: formView, submitView: formView, validatorHandler: nil)
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
        let dependencies = BeagleDependencies()
        dependencies.network = NetworkStub(
            componentResult: .success(SimpleComponent().content)
        )

        let sut = BeagleScreenViewController(viewModel: .init(
            screenType: .remote(.init(url: "")),
            dependencies: dependencies
        ))

        assertSnapshotImage(sut)
    }
    
    func test_lazyLoad_withUpdatableView_shouldCallUpdate() {
        // Given
        let initialView = OnStateUpdatableViewSpy()
        initialView.yoga.isEnabled = true
        let networkStub = NetworkStub(
            componentResult: .success(ComponentDummy())
        )
        let sut = BeagleScreenViewController(viewModel: .init(
            screenType: .declarative(ComponentDummy().toScreen()),
            dependencies: BeagleScreenDependencies(
                network: networkStub
            )
        ))
        sut.view.addSubview(initialView)
        
        // When
        sut.lazyLoad(url: "URL", initialState: initialView)
        
        // Then
        XCTAssert(initialView.superview != nil)
        XCTAssert(initialView.didCallOnUpdateState)
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

class FormInputViewStub: UIView, InputValue, ValidationErrorListener, WidgetStateObservable {
    var observable = Observable<WidgetState>(value: WidgetState(value: false))
    
    let value: String

    init(_ formInput: FormInput, value: String = "") {
        self.value = value
        super.init(frame: .zero)
        self.beagleFormElement = formInput
    }

    required init?(coder: NSCoder) {
        BeagleUI.fatalError("init(coder:) has not been implemented")
    }

    func getValue() -> Any {
        return value
    }
    func onValidationError(message: String?) {
    }
}

private class FormSubmitViewStub: UIView, Observer, WidgetStateObservable {
    var observable: Observable<WidgetState> = Observable<WidgetState>(value: WidgetState(value: false))
    var didCallChangeValue = false
    
    init(_ formSubmit: FormSubmit) {
        super.init(frame: .zero)
        self.beagleFormElement = formSubmit
    }
    
    required init?(coder: NSCoder) {
        BeagleUI.fatalError("init(coder:) has not been implemented")
    }
    
    func didChangeValue(_ value: Any?) {
        didCallChangeValue = true
    }
}

class OnStateUpdatableViewSpy: UIView, OnStateUpdatable {
    private(set) var didCallOnUpdateState = false
    
    func onUpdateState(component: ServerDrivenComponent) -> Bool {
        didCallOnUpdateState = true
        return true
    }
}
