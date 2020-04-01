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

import UIKit

/// Interface to access application specific operations
public protocol BeagleContext: AnyObject {
    
    var screenController: UIViewController { get }
    
    func applyLayout()
    func register(action: Action, inView view: UIView)
    func register(form: Form, formView: UIView, submitView: UIView, validatorHandler: ValidatorProvider?)
    func lazyLoad(url: String, initialState: UIView)
    func doAction(_ action: Action, sender: Any)
}

extension BeagleScreenViewController: BeagleContext {
    
    public var screenController: UIViewController {
        return self
    }
    
    public func register(action: Action, inView view: UIView) {
        
        let gestureRecognizer = ActionGestureRecognizer(
            action: action,
            target: self,
            selector: #selector(handleActionGesture(_:)))
        view.addGestureRecognizer(gestureRecognizer)
        view.isUserInteractionEnabled = true
    }
    
    public func applyLayout() {
        guard let componentView = componentView else { return }
        componentView.frame = view.bounds
        componentView.flex.applyLayout()
    }
    
    public func register(form: Form, formView: UIView, submitView: UIView, validatorHandler: ValidatorProvider?) {
        let gestureRecognizer = SubmitFormGestureRecognizer(
            form: form,
            formView: formView,
            formSubmitView: submitView,
            validator: validatorHandler,
            target: self,
            action: #selector(handleSubmitFormGesture(_:))
        )
        if let control = submitView as? UIControl,
           let formSubmit = submitView.beagleFormElement as? FormSubmit,
           let enabled = formSubmit.enabled {
            control.isEnabled = enabled
        }
        
        submitView.addGestureRecognizer(gestureRecognizer)
        submitView.isUserInteractionEnabled = true
        gestureRecognizer.updateSubmitView()
    }
    
    public func lazyLoad(url: String, initialState: UIView) {
        dependencies.network.fetchComponent(url: url, additionalData: nil) {
            [weak self] result in guard let self = self else { return }

            switch result {
            case .success(let component):
                self.update(initialView: initialState, lazyLoaded: component)

            case .failure(let error):
                self.viewModel.handleError(error)
            }
        }
    }
    
    public func doAction(_ action: Action, sender: Any) {
        dependencies.actionExecutor.doAction(action, sender: sender, context: self)
    }
    
    // MARK: - Action
    
    @objc func handleActionGesture(_ sender: ActionGestureRecognizer) {
        dependencies.actionExecutor.doAction(sender.action, sender: sender, context: self)
    }
    
    // MARK: - Form
    
    @objc func handleSubmitFormGesture(_ sender: SubmitFormGestureRecognizer) {
        if let control = sender.formSubmitView as? UIControl, !control.isEnabled {
            return
        }
        let inputViews = sender.formInputViews()
        if inputViews.isEmpty {
            dependencies.logger.log(Log.form(.inputsNotFound(path: sender.form.path)))
        }
        let values = inputViews.reduce(into: [:]) {
            self.validate(formInput: $1, formSubmit: sender.formSubmitView, validatorHandler: sender.validator, result: &$0)
        }
        guard inputViews.count == values.count else {
            dependencies.logger.log(Log.form(.divergentInputViewAndValueCount(path: sender.form.path)))
            return
        }
        makeRequest(sender: sender, values: values)
        
    }

    private func makeRequest(sender: SubmitFormGestureRecognizer, values: [String: String]) {
        view.showLoading(.whiteLarge)

        let data = Request.FormData(
            method: sender.form.method,
            values: values
        )

        dependencies.network.submitForm(
            url: sender.form.path,
            additionalData: nil,
            data: data
        ) {
            [weak self] result in guard let self = self else { return }

            self.view.hideLoading()
            self.handleFormResult(result, sender: sender)
        }
        dependencies.logger.log(Log.form(.submittedValues(values: values)))
    }
    
    private func validate(formInput view: UIView, formSubmit submitView: UIView?, validatorHandler: ValidatorProvider?, result: inout [String: String]) {
        guard
            let formInput = view.beagleFormElement as? FormInputComponent,
            let inputValue = view as? InputValue else {
                return
        }
        if let defaultFormInput = formInput as? FormInput, defaultFormInput.required ?? false {
            guard
                let validatorName = defaultFormInput.validator,
                let handler = validatorHandler,
                let validator = handler.getValidator(name: validatorName) else {
                    if let validatorName = defaultFormInput.validator {
                        dependencies.logger.log(Log.form(.validatorNotFound(named: validatorName)))
                    }
                    return
            }
            let value = inputValue.getValue()
            let isValid = validator.isValid(input: value)
                        
            if isValid {
                result[formInput.name] = String(describing: value)
            } else {
                if let errorListener = inputValue as? ValidationErrorListener {
                    errorListener.onValidationError(message: defaultFormInput.errorMessage)
                }
                dependencies.logger.log(Log.form(.validationInputNotValid(inputName: defaultFormInput.name)))
            }
        } else {
            result[formInput.name] = String(describing: inputValue.getValue())
        }
    }
    
    private func handleFormResult(_ result: Result<Action, Request.Error>, sender: Any) {
        switch result {
        case .success(let action):
            dependencies.actionExecutor.doAction(action, sender: sender, context: self)
        case .failure(let error):
            viewModel.handleError(error)
        }
    }
    
    // MARK: - Lazy Load
    
    private func update(initialView: UIView, lazyLoaded: ServerDrivenComponent) {
        let updatable = initialView as? OnStateUpdatable
        let updated = updatable?.onUpdateState(component: lazyLoaded) ?? false

        if updated && initialView.flex.isEnabled {
            initialView.flex.markDirty()
        } else if !updated {
            replaceView(initialView, with: lazyLoaded)
        }
        applyLayout()
    }
    
    private func replaceView(_ oldView: UIView, with component: ServerDrivenComponent) {
        guard let superview = oldView.superview else { return }
        
        let newView = component.toView(context: self, dependencies: dependencies)
        newView.frame = oldView.frame
        superview.insertSubview(newView, belowSubview: oldView)
        oldView.removeFromSuperview()
        
        if oldView.flex.isEnabled && !newView.flex.isEnabled {
            newView.flex.isEnabled = true
        }
    }
    
}
