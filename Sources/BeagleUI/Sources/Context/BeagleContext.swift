import UIKit

/// Interface to access application specific operations
public protocol BeagleContext: AnyObject {
    
    var screenController: UIViewController { get }
    
    func register(action: Action, inView view: UIView)
    func register(form: Form, formView: UIView, submitView: UIView, validator: ValidatorProvider?)
    
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
    
    public func register(form: Form, formView: UIView, submitView: UIView, validator: ValidatorProvider?) {
        let gestureRecognizer = SubmitFormGestureRecognizer(
            form: form,
            formView: formView,
            validator: validator,
            target: self,
            action: #selector(handleSubmitFormGesture(_:))
        )
        submitView.addGestureRecognizer(gestureRecognizer)
        submitView.isUserInteractionEnabled = true
    }
    
    public func lazyLoad(url: String, initialState: UIView) {
        dependencies.network.fetchWidget(url: url) {
            [weak self] result in guard let self = self else { return }

            switch result {
            case .success(let widget):
                self.update(initialView: initialState, lazyLoaded: widget)

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
        let inputViews = sender.formInputViews()
        let values = inputViews.reduce(into: [:]) {
            self.validate(formInput: $1, validatorHandler: sender.validator, result: &$0)
        }

        guard inputViews.count == values.count else { return }

        makeRequest(sender: sender, values: values)
    }

    private func makeRequest(sender: SubmitFormGestureRecognizer, values: [String: String]) {
        view.showLoading(.whiteLarge)

        let data = Request.FormData(
            method: sender.form.method,
            values: values
        )

        dependencies.network.submitForm(
            url: sender.form.action,
            data: data
        ) {
            [weak self] result in guard let self = self else { return }

            self.view.hideLoading()
            self.handleFormResult(result, sender: sender)
        }
    }
    
    private func validate(formInput view: UIView, validatorHandler: ValidatorProvider?, result: inout [String: String]) {
        guard
            let formInput = view.beagleFormElement as? FormInput,
            let inputValue = view as? InputValue else {
                return
        }
        if formInput.required ?? false {
            guard
                let validatorName = formInput.validator,
                let handler = validatorHandler,
                let validator = handler.getValidator(name: validatorName) else {
                    return
            }
            let value = inputValue.getValue()
            if validator.isValid(input: value) {
                result[formInput.name] = String(describing: value)
            } else if let errorListener = inputValue as? ValidationErrorListener {
                errorListener.onValidationError(message: formInput.errorMessage)
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
    
    private func update(initialView: UIView, lazyLoaded: Widget) {
        let updatable = initialView as? OnStateUpdatable
        let updated = updatable?.onUpdateState(widget: lazyLoaded) ?? false
        if updated && initialView.isYogaEnabled {
            initialView.yoga.markDirty()
        } else if !updated {
            replaceView(initialView, with: lazyLoaded)
        }
        if let widgetView = self.rootWidgetView.subviews.first {
            widgetView.frame = self.rootWidgetView.bounds
            dependencies.flex.applyYogaLayout(to: widgetView, preservingOrigin: true)
        }
    }
    
    private func replaceView(_ view: UIView, with widget: Widget) {
        guard let superview = view.superview else { return }

        let updatedView = widget.toView(context: self, dependencies: dependencies)
        updatedView.frame = view.frame
        superview.insertSubview(updatedView, belowSubview: view)
        view.removeFromSuperview()
    }
    
}
