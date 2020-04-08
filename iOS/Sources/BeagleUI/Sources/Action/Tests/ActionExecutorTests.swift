/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import XCTest
@testable import BeagleUI

final class ActionExecutorTests: XCTestCase {

    private struct Dependencies: ActionExecuting.Dependencies {
        
        var customActionHandler: CustomActionHandler?
        var navigation: BeagleNavigation
        
        init(
            customActionHandler: CustomActionHandler = CustomActionHandlerDummy(),
            navigation: BeagleNavigation = BeagleNavigator(dependencies: NavigatorDependencies())
        ) {
            self.customActionHandler = customActionHandler
            self.navigation = navigation
        }
    }

    func test_whenExecuteNavigateAction_shouldUseTheNavigator() {
        // Given
        let navigationSpy = BeagleNavigationSpy()
        let sut = ActionExecuting(dependencies: Dependencies(
            navigation: navigationSpy
        ))
        let action = Navigate.addView(.init(path: ""))
        
        // When
        sut.doAction(action, sender: self, context: BeagleContextDummy())
        
        // Then
        XCTAssertTrue(navigationSpy.didCallNavigate)
    }
    
    func test_whenExecuteFormValidation_shouldCallErrorListener() {
        // Given
        let sut = ActionExecuting(dependencies: Dependencies())
        let inputName = "inputName"
        let errorMessage = "Error Message"
        let fieldError = FieldError(inputName: inputName, message: errorMessage)
        let action = FormValidation(errors: [fieldError])
        
        let formInput = FormInput(name: inputName, child: ComponentDummy())
        let validationErrorListenerSpy = ValidationErrorListenerSpy()
        validationErrorListenerSpy.beagleFormElement = formInput
        let form = Form(
            action: FormRemoteAction(path: "path", method: .post),
            child: Container(children: [formInput])
        )
        let formView = UIView()
        let formSubmitView = UIView()
        formView.addSubview(validationErrorListenerSpy)
        let sender = SubmitFormGestureRecognizer(form: form, formView: formView, formSubmitView: formSubmitView, validator: nil)
        
        // When
        sut.doAction(action, sender: sender, context: BeagleContextDummy())
        
        // Then
        XCTAssertEqual(validationErrorListenerSpy.validationErrorMessage, errorMessage)
    }
    
    func test_whenShowNativeDialog_shouldPresentAlertController() {
        // Given
        let sut = ActionExecuting(dependencies: Dependencies())
        let action = ShowNativeDialog(
            title: "Title",
            message: "Message",
            buttonText: "Button")
        
        let viewControllerSpy = UINavigationControllerSpy()
        let context = BeagleContextDummy(viewController: viewControllerSpy)
        
        // When
        sut.doAction(action, sender: self, context: context)
        
        // Then
        XCTAssertTrue(viewControllerSpy.presentViewControllerCalled)
    }
    
    func test_whenExecuteCustomAction_shouldUseActionHandler() {
        // Given
        let actionSpy = CustomActionHandlerSpy()
        let sut = ActionExecuting(dependencies: Dependencies(
            customActionHandler: actionSpy
        ))
        let action = CustomAction(name: "custom-action", data: [:])
        
        // When
        sut.doAction(action, sender: self, context: BeagleContextDummy())
        
        // Then
        XCTAssertEqual(actionSpy.actionsHandledCount, 1)
    }

    func test_whenExecuteCustomAction_shouldListenToStateChanges() {
        // Given
        let name = "name"
        let error = NSError()

        let handler: CustomActionHandling.Handler = { context, action, listener in
            listener(.start)
            listener(.error(error))
            listener(.success(action: ActionDummy()))
        }

        let expectedStates: [BeagleScreenViewModel.State] = [.loading, .loading, .failure(.action(error)), .rendered]

        let handlers = CustomActionHandling(handlers: [name: handler])

        let model = BeagleScreenViewModelMock(screenType: .remote(.init(url: "")))
        let view = BeagleScreenViewController(viewModel: model)

        let executor = ActionExecuting(dependencies: Dependencies(customActionHandler: handlers))
        let action = CustomAction(name: name, data: [:])

        // When
        executor.doAction(action, sender: self, context: view)

        // Then
        XCTAssert(model.changedStates == expectedStates)
    }
}

// MARK: - Test helpers

class CustomActionHandlerDummy: CustomActionHandler {
    func handle(context: BeagleContext, action: CustomAction, listener: Listener) {
    }
}

class BeagleNavigationSpy: BeagleNavigation {
    private(set) var didCallNavigate = false

    func navigate(action: Navigate, context: BeagleContext, animated: Bool) {
        didCallNavigate = true
    }
}

class CustomActionHandlerSpy: CustomActionHandler {
    private(set) var actionsHandledCount = 0

    func handle(context: BeagleContext, action: CustomAction, listener: Listener) {
        actionsHandledCount += 1
    }
}

class ValidationErrorListenerSpy: UIView, ValidationErrorListener {
    private(set) var validationErrorMessage: String?

    func onValidationError(message: String?) {
        validationErrorMessage = message
    }
}

class BeagleScreenViewModelMock: BeagleScreenViewModel {

    override var state: BeagleScreenViewModel.State {
        didSet { saveState(state) }
    }

    var changedStates = [State]()

    func saveState(_ state: BeagleScreenViewModel.State) {
        changedStates.append(state)
    }
}

extension BeagleScreenViewModel.State: Equatable {
    public static func == (lhs: BeagleScreenViewModel.State, rhs: BeagleScreenViewModel.State) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading): return true
        case (.rendered, .rendered): return true
        case (.success, .success): return true
        case (.failure, .failure): return true
        default: return false
        }
    }
}
