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
    
    public init(
        entity: EntityPair<E>,
        view: ViewPair<W>
    ) {
        self.entity = entity
        self.view = view
    }
    
    /// Defines a pair (typeName, type) for describing a WidgetEntity
    public struct EntityPair<E: WidgetEntity> {
        public let typeName: String
        public let type: E.Type
        
        public init(
            typeName: String,
            type: E.Type
        ) {
            self.typeName = typeName
            self.type = type
        }
    }
    
    /// Defines a pair (widgetType, viewRenderer) for describing a UI-related representation of a Widget
    public struct ViewPair<W: Widget> {
        public let widgetType: W.Type
        public let viewRenderer: WidgetViewRenderer<W>.Type
        
        public init(
            widgetType: W.Type,
            viewRenderer: WidgetViewRenderer<W>.Type
        ) {
            self.widgetType = widgetType
            self.viewRenderer = viewRenderer
        }
    }
    
}
