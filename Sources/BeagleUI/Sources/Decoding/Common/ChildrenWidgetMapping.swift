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
    func mapChildren() throws -> [Widget]
}
extension ChildrenWidgetMapping {
    
    /// Maps a child property to Widget
    ///
    /// - Returns: a the child property as a Widget
    /// - Throws: a WidgetConvertibleError when present
    func mapChildren() throws -> [Widget] {
        
        let mirror = Mirror(reflecting: self)
        
        // swiftlint:disable trailing_closure
        let children = mirror.children.first(where: { $0.label == "children" })?.value as? [WidgetConvertibleEntity]

        var childWidgets = [Widget]()
        try children?.forEach {
            let widget = try $0.mapToWidget()
            childWidgets.append(widget)
        }
        
        return childWidgets
        
    }
    
}
