//
//  NavigationBarEntity.swift
//  BeagleUI
//
//  Created by Gabriela Coelho on 18/11/19.
//  Copyright © 2019 Zup IT. All rights reserved.
//

struct NavigationBarEntity: WidgetConvertibleEntity {
    let title: String
    let leading: AnyDecodableContainer?
    let trailing: AnyDecodableContainer?
    
    func mapToWidget() throws -> Widget {
        
        let leadingEntity = self.leading?.content as? WidgetConvertibleEntity
        let leading = try leadingEntity?.mapToWidget()
        
        let trailingEntity = self.trailing?.content as? WidgetConvertibleEntity
        let trailing = try trailingEntity?.mapToWidget()
        
        return NavigationBar(title: title,
                             leading: leading,
                             trailing: trailing)
    }
}
