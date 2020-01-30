//
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import UIKit

public struct Form: Widget {
    
    // MARK: - Public Properties
    
    public let action: String
    public let method: MethodType
    public let child: Widget
    
    // MARK: - Initialization
    
    public init(
        action: String,
        method: MethodType,
        child: Widget
    ) {
        self.action = action
        self.method = method
        self.child = child
    }
}

extension Form {
    public enum MethodType: String, StringRawRepresentable {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }
}

extension Form: Renderable {
    public func toView(context: BeagleContext, dependencies: Renderable.Dependencies) -> UIView {
        let childView = child.toView(context: context, dependencies: dependencies)
        
        func registerFormSubmit(view: UIView) {
            if view.beagleFormElement is FormSubmit {
                context.register(form: self, formView: childView, submitView: view, validator: dependencies.validatorProvider)
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
