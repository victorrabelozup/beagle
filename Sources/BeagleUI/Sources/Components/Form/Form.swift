//
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import UIKit

public struct Form: ServerDrivenComponent {
    
    // MARK: - Public Properties
    
    public let path: String
    public let method: MethodType
    public let child: ServerDrivenComponent
    
    // MARK: - Initialization
    
    public init(
        path: String,
        method: MethodType,
        child: ServerDrivenComponent
    ) {
        self.path = path
        self.method = method
        self.child = child
    }
}

extension Form {
    public enum MethodType: String, StringRawRepresentable, CaseIterable {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }
}

extension Form: Renderable {
    public func toView(context: BeagleContext, dependencies: RenderableDependencies) -> UIView {
        let childView = child.toView(context: context, dependencies: dependencies)
        
        func registerFormSubmit(view: UIView) {
            if view.beagleFormElement is FormSubmit {
                context.register(form: self, formView: childView, submitView: view, validatorHandler: dependencies.validatorProvider)
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
    
    var beagleFormElement: ServerDrivenComponent? {
        get {
            return (objc_getAssociatedObject(self, &AssociatedKeys.FormElement) as? ObjectWrapper)?.object
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.FormElement, ObjectWrapper(newValue), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
