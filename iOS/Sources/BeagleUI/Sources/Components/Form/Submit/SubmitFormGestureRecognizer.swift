//
//  Copyright © 2019 Zup IT. All rights reserved.
//

import UIKit

final class SubmitFormGestureRecognizer: UITapGestureRecognizer {
    
    let form: Form
    weak var formView: UIView?
    weak var formSubmitView: UIView?
    let validator: ValidatorProvider?
    
    init(form: Form, formView: UIView, formSubmitView: UIView, validator: ValidatorProvider?, target: Any? = nil, action: Selector? = nil) {
        self.form = form
        self.formView = formView
        self.formSubmitView = formSubmitView
        self.validator = validator
        super.init(target: target, action: action)
        self.setupFormObservables()
    }
    
    private func setupFormObservables() {
        guard let observer = formSubmitView?.superview as? Observer else { return }
        formView?.allSubviews
            .compactMap { $0 as? WidgetStateObservable }
            .forEach { $0.observable.addObserver(observer) }
    }
    
    func formInputViews() -> [UIView] {
        var inputViews = [UIView]()
        var pendingViews = [UIView]()
        if let formView = formView {
            pendingViews.append(formView)
        }
        while let view = pendingViews.popLast() {
            if view.beagleFormElement is FormInput {
                inputViews.append(view)
            } else {
                pendingViews.append(contentsOf: view.subviews)
            }
        }
        return inputViews
    }
    
    func updateSubmitView() {
        guard let control = formSubmitView as? UIControl else { return }
        let formSubmitEnabled = (formSubmitView?.beagleFormElement as? FormSubmit)?.enabled ?? true
        control.isEnabled = formSubmitEnabled || formIsValid()
    }
    
    private func formIsValid() -> Bool {
        for inputView in formInputViews() {
            guard
                let formInput = inputView.beagleFormElement as? FormInput,
                let inputValue = inputView as? InputValue else {
                    return false
            }
            if formInput.required ?? false {
                guard
                    let validatorName = formInput.validator,
                    let validatorProvider = validator,
                    let validator = validatorProvider.getValidator(name: validatorName),
                    validator.isValid(input: inputValue.getValue()) else {
                        return false
                }
            }
        }
        return true
    }
    
}
