//
//  FormWidgetViewRenderer.swift
//  BeagleUI
//
//  Created by Lucas Araújo on 18/11/19.
//  Copyright © 2019 Zup IT. All rights reserved.
//

import UIKit

final class FormWidgetViewRenderer: WidgetViewRenderer<Form> {
        
    // MARK: - Public Functions
    
    override func buildView(context: BeagleContext) -> UIView {
        let child = widget.child
        let childRenderer = self.rendererProvider.buildRenderer(for: child, dependencies: dependencies)
        let childView = childRenderer.buildView(context: context)
        
        func registerFormSubmit(view: UIView) {
            if view.beagleFormElement is FormSubmit {
                context.register(form: widget, formView: childView, submitView: view, validator: self.validatorProvider)
            }
            for subview in view.subviews {
                registerFormSubmit(view: subview)
            }
        }
        
        registerFormSubmit(view: childView)
        return childView
    }
    
}

extension UIView {
    private struct AssociatedKeys {
        static var FormElement = "beagleUI_FormElement"
    }
    
    private class ObjectWrapper<T> {
        let object: T?
        
        init(_ object: T?) {
            self.object = object
        }
    }
    
    var beagleFormElement: Widget? {
        get {
            return (objc_getAssociatedObject(self, &AssociatedKeys.FormElement) as? ObjectWrapper)?.object
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.FormElement, ObjectWrapper(newValue), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
