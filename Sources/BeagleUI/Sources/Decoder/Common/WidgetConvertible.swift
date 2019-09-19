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
    
    case emptyContentForContainerOfType(String)
    case couldNotFindChildrenPropertyForType(String)
    case unexpectedNilChildrensForType(String)
    
    var localizedDescription: String {
        switch self {
        case let .emptyContentForContainerOfType(type):
            return "Empty content for container of \(type)"
        case let .couldNotFindChildrenPropertyForType(type):
            return "Could not find `children` property for \(type)"
        case let .unexpectedNilChildrensForType(type):
            return "A `nil` value was found for the `children` property for \(type) when it was not expected."
        }
    }
}
