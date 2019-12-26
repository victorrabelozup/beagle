//
//  NavigatorEntity.swift
//  BeagleUI
//
//  Created by Lucas Araújo on 04/11/19.
//  Copyright © 2019 Zup IT. All rights reserved.
//

struct NavigatorEntity: WidgetConvertibleEntity {
    
    let action: NavigateEntity
    let child: AnyDecodableContainer
    
    func mapToWidget() throws -> Widget {
        let widgetEntity = self.child.content as? WidgetConvertibleEntity
        let child = try widgetEntity?.mapToWidget() ?? AnyWidget(value: self.child.content)
        
        return Navigator(
            action: try action.mapToUIModel(),
            child: child
        )
    }
}
