//
//  SubmitFormGestureRecognizer.swift
//  BeagleUI
//
//  Created by Lucas Araújo on 22/11/19.
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
        formView?.allSubviews.forEach { subview in
            guard let widgetStateObservable = subview as? WidgetStateObservable,
                let formSubmitStateObservable = formSubmitView as? WidgetStateObservable,
                let observer = formSubmitView as? Observer else {
                    return
            }
            formSubmitStateObservable.observable.addObserver(observer)
            widgetStateObservable.observable.addObserver(observer)
        }
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
    
}
