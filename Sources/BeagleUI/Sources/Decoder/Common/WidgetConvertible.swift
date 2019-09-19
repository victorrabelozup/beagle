//
//  WidgetConvertible.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 18/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

/// Serves as a gateway between APIEntities and UIModels
protocol WidgetConvertible {
    func mapToWidget() throws -> Widget
}

/// Describes the possible errors when mapping to a UIModel (Widget)
///
/// - emptyContentForContainerOfType: some container has an empty content, when it shouldn't
/// - couldNotFindChildrenPropertyForType: some entity that should have a `children` property does not have it
enum WidgetConvertibleError: Error {
    
    case emptyContentForContainerOfType(String)
    case couldNotFindChildrenPropertyForType(String)
    
    var localizedDescription: String {
        switch self {
        case let .emptyContentForContainerOfType(type):
            return "Empty content for container of \(type)"
        case let .couldNotFindChildrenPropertyForType(type):
            return "Could not find `children` property for \(type)"
        }
    }
}

/// Maps a child property to Widget
protocol ChildWidgetMapping {
    func mapChildren() throws -> [Widget]
}
extension ChildWidgetMapping {
    
    func mapChildren() throws -> [Widget] {
        
        let mirror = Mirror(reflecting: self)
        guard let children = mirror.children.first(where: { $0.label == "children" })?.value as? [WidgetEntityContainer] else {
            let type = String(describing: self)
            throw WidgetConvertibleError.couldNotFindChildrenPropertyForType(type)
        }
        
        var childWidgets = [Widget]()
        try children.forEach {
            guard let content = $0.content else {
                throw WidgetConvertibleError.emptyContentForContainerOfType($0.type)
            }
            let widget = try content.mapToWidget()
            childWidgets.append(widget)
        }
        return childWidgets
        
    }
    
}
