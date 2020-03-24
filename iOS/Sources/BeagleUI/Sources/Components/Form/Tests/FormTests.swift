//
// Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//       http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

import XCTest
import SnapshotTesting
@testable import BeagleUI

// TODO: refactor this tests that are not actually asserting against behaviour

final class FormTests: XCTestCase {
    
    func test_initWithChild_shouldReturnValidForm() {
        // Given / When
        let sut = Form(path: "path", method: .get, child:
            Text("Teste")
        )
        // Then
        XCTAssertTrue(sut.child is Text)
    }
    
    func test_buildView_shouldRegisterFormSubmit() throws {
        // Given
        let child = Container(children: [FormSubmit(child: Text("submit"))])
        let form = Form(path: "/singup", method: .post, child: child)
        let context = BeagleContextSpy()
                
        // When
        _ = form.toView(context: context, dependencies: BeagleScreenDependencies())
        
        // Then
        XCTAssertTrue(context.didCallRegisterFormSubmit)
    }
    
    func test_whenDecodingJson_thenItShouldReturnAForm() throws {
        let component: Form = try componentFromJsonFile(fileName: "formComponent")
        assertSnapshot(matching: component, as: .dump)
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

    func test_formSubmit_shouldPassRightDataToBeSubmitted() {
        // Given
        let component = SimpleComponent()
        let networkStub = NetworkStub()

        let sut = BeagleScreenViewController(viewModel: .init(
            screenType: .declarative(component.content.toScreen()),
            dependencies: BeagleScreenDependencies(
                network: networkStub
            )
        ))

        let form = Form(path: "submit", method: .post, child: ComponentDummy())
        let validInput = FormInput(name: "name", child: ComponentDummy())
        let formInputHidden = FormInputHidden(name: "id", value: "123123")
        let formSubmit = FormSubmit(child: Button(text: "Add"), enabled: true)
        let validInputView = FormInputViewStub(validInput, value: "John Doe")
        let formInputHiddenView = FormInputHiddenViewStub(formInputHidden, value: "123123")
        let formSubmitView = FormSubmitViewStub(formSubmit)
        let formView = UIView()
        formView.addSubview(validInputView)
        formView.addSubview(formSubmitView)
        formView.addSubview(formInputHiddenView)

        sut.register(form: form, formView: formView, submitView: formSubmitView, validatorHandler: nil)
        guard let gesture = formSubmitView.gestureRecognizers?.first as? SubmitFormGestureRecognizer else {
            XCTFail("Could not find `SubmitFormGestureRecognizer`.")
            return
        }

        // When
        sut.handleSubmitFormGesture(gesture)

        // Then
        let submittedData = networkStub.formData

        XCTAssert(networkStub.didCallDispatch == true)
        assertSnapshot(matching: submittedData, as: .dump)
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
}

// MARK: - Stubs

private class FormInputViewStub: UIView, InputValue, ValidationErrorListener, WidgetStateObservable {
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

private class FormInputHiddenViewStub: UIView, InputValue {

    let value: String

    init(_ formInputHidden: FormInputHidden, value: String) {
        self.value = value
        super.init(frame: .zero)
        self.beagleFormElement = formInputHidden
    }

    required init?(coder: NSCoder) {
        BeagleUI.fatalError("init(coder:) has not been implemented")
    }

    func getValue() -> Any {
        return value
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
