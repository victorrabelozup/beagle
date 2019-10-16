//
//  WidgetRegisterItem.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 14/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

/// Defines a holder for entity and view types, in order to register custom widgets
public struct WidgetRegisterItem<E: WidgetConvertibleEntity, W: Widget> {
    
    let entity: EntityPair<E>
    let view: ViewPair<W>
    
    /// Defines a pair (typeName, type) for describing a WidgetEntity
    public struct EntityPair<E: WidgetEntity> {
        public let typeName: String
        public let type: E.Type
    }
    
    /// Defines a pair (widgetType, viewRenderer) for describing a UI-related representation of a Widget
    public struct ViewPair<W: Widget> {
        public let widgetType: W.Type
        public let viewRenderer: WidgetViewRenderer<W>.Type
    }
    
}
