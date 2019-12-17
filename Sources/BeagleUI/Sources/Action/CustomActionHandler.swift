//
//  CustomActionHandler.swift
//  BeagleUI
//
//  Created by Lucas Araújo on 21/11/19.
//  Copyright © 2019 Zup IT. All rights reserved.
//

import Foundation

public protocol CustomActionHandler {
    func handle(context: BeagleContext, action: CustomAction)
}

public protocol DependencyCustomActionHandler {
    var customActionHandler: CustomActionHandler? { get }
}

public final class CustomActionHandling: CustomActionHandler {
    
    public typealias CustomActionClosure = (BeagleContext, CustomAction) -> Void
    
    private var handlers: [String: CustomActionClosure]
    
    public init(handlers: [String: CustomActionClosure] = [:]) {
        self.handlers = handlers
    }
    
    public func handle(context: BeagleContext, action: CustomAction) {
        self[action.name]?(context, action)
    }
    
    public subscript(name: String) -> CustomActionClosure? {
        get {
            return handlers[name]
        }
        set {
            handlers[name] = newValue
        }
    }
}
