//
//  WidgetRegisterItem.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 14/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

public struct WidgetRegisterItem<E: WidgetConvertibleEntity, W: Widget, R: WidgetViewRenderer> {
    
    let entity: EntityPair<E>
    let view: ViewPair<W, R>
    
    public struct EntityPair<E: WidgetEntity> {
        let typeName: String
        let type: E.Type
    }
    
    public struct ViewPair<W: Widget, R: WidgetViewRenderer> {
        let widgetType: W.Type
        let viewRenderer: R.Type
    }
    
}
