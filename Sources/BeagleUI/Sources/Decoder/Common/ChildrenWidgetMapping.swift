//
//  ChildrenWidgetMapping.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 19/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

/// Maps a child property to Widget
protocol ChildrenWidgetMapping {
    
    /// Maps a child property to Widget
    ///
    /// - Returns: a the child property as a Widget
    /// - Throws: a WidgetConvertibleError when present
    func mapChildren() throws -> [Widget]?
}
extension ChildrenWidgetMapping {
    
    /// Maps a child property to Widget
    ///
    /// - Returns: a the child property as a Widget
    /// - Throws: a WidgetConvertibleError when present
    func mapChildren() throws -> [Widget]? {
        
        let mirror = Mirror(reflecting: self)
        guard let childrenProperty = mirror.children.first(where: { $0.label == "children" })?.value as? [WidgetEntityContainer]? else {
            let type = String(describing: self)
            throw WidgetConvertibleError.couldNotFindChildrenPropertyForType(type)
        }
        
        guard let children = childrenProperty else {
            return nil
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
