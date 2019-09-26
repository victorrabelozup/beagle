//
//  WidgetConvertible.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 18/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

/// Serves as a gateway between APIEntities and UIModels
public protocol WidgetConvertible {
    func mapToWidget() throws -> Widget
}

/// Describes the possible errors when mapping to a UIModel (Widget)
///
/// - emptyContentForContainerOfType: some container has an empty content, when it shouldn't
/// - couldNotFindChildrenPropertyForType: some entity that should have a `children` property does not have it
/// - unexpectedNilChildrensForType: a nil value was received for the `children`property when it was not expected
public enum WidgetConvertibleError: Error {
    
    case entityTypeIsNotConvertible(String)
    
    var localizedDescription: String {
        switch self {
        case let .entityTypeIsNotConvertible(type):
            return "\(type) does not conform with `WidgetConvertible`. Check this."
        }
    }
}
