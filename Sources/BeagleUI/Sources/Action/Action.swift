//
//  Copyright © 2019 Zup IT. All rights reserved.
//

/// Markup to define an action to be triggred in response to some event
public protocol Action {
}

/// Defines a representation of an unknwon Action
public struct AnyAction: Action {
    public let value: Any
    
    public init(value: Any) {
        self.value = value
    }
}
