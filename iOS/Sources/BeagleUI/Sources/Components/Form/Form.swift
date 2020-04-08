/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import UIKit

public struct Form: ServerDrivenComponent {
    
    // MARK: - Public Properties

    public let action: Action
    public let child: ServerDrivenComponent
    
    // MARK: - Initialization
    
    public init(
        action: Action,
        child: ServerDrivenComponent
    ) {
        self.action = action
        self.child = child
    }
}

extension Form: Renderable {
    public func toView(context: BeagleContext, dependencies: RenderableDependencies) -> UIView {
        let childView = child.toView(context: context, dependencies: dependencies)
        var hasFormSubmit = false
        
        func registerFormSubmit(view: UIView) {
            if view.beagleFormElement is FormSubmit {
                hasFormSubmit = true
                context.register(form: self, formView: childView, submitView: view, validatorHandler: dependencies.validatorProvider)
            }
            for subview in view.subviews {
                registerFormSubmit(view: subview)
            }
        }
        
        registerFormSubmit(view: childView)
        if !hasFormSubmit {
            dependencies.logger.log(Log.form(.submitNotFound(form: self)))
        }
        return childView
    }    
}

extension Form: Decodable {
    enum CodingKeys: String, CodingKey {
        case action
        case child
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.action = try container.decode(forKey: .action)
        self.child = try container.decode(forKey: .child)
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
