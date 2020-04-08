/*
 * Copyright 2020 ZUP IT SERVICOS EM TECNOLOGIA E INOVACAO SA
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import Foundation

/// Your application can define CustomActions, and Beagle will ask to the CustomActionHandler defined by your application
/// to handle what the custom actions will do.
public protocol CustomActionHandler {

    /// here you should see which custom action you are receiving, and execute its logic.
    func handle(context: BeagleContext, action: CustomAction, listener: Listener)

    /// use it to inform Beagle about the on going execution
    typealias Listener = (CustomActionState) -> Void
}

public protocol DependencyCustomActionHandler {
    var customActionHandler: CustomActionHandler? { get }
}

public final class CustomActionHandling: CustomActionHandler {
    
    public typealias Handler = (BeagleContext, CustomAction, Listener) -> Void
    
    private var handlers: [String: Handler]
    
    public init(handlers: [String: Handler] = [:]) {
        self.handlers = handlers
    }
    
    public func handle(context: BeagleContext, action: CustomAction, listener: Listener) {
        self[action.name]?(context, action, listener)
    }
    
    public subscript(name: String) -> Handler? {
        get {
            return handlers[name]
        }
        set {
            handlers[name] = newValue
        }
    }
}

public enum CustomActionState {
    case start
    case error(Error)
    case success(action: Action)
}
