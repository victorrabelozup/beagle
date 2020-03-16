//
//  Copyright © 2019 Zup IT. All rights reserved.
//

/// Markup to define an action to be triggred in response to some event
public protocol Action: Decodable {}

/// Defines a representation of an unknwon Action
public struct UnknownAction: Action {
    public let type: String
    
    public init(type: String) {
        self.type = type
    }
}
