//
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

/// Serves as a gateway between APIEntities and UIModels
public protocol ComponentConvertible {
    func mapToComponent() throws -> ServerDrivenComponent
}

/// Describes the possible errors when mapping to a UIModel (Component)
public enum ComponentConvertibleError: Error {
    
    case entityTypeIsNotConvertible(String)
    case invalidType
    
    var localizedDescription: String {
        switch self {
        case let .entityTypeIsNotConvertible(type):
            return "\(type) does not conform with `ComponentConvertible`. Check this."
        case .invalidType:
            return "invalid type"
        }
        
    }
}
