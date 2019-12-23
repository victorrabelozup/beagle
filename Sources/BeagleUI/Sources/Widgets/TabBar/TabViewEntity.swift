//
//  TabViewEntity.swift
//  BeagleUI
//
//  Created by Gabriela Coelho on 21/11/19.
//  Copyright © 2019 Zup IT. All rights reserved.
//

import Foundation

/// Defines an API representation for `TabView`
struct TabViewEntity: WidgetEntity {
    let tabItems: [AnyDecodableContainer]
}

extension TabViewEntity: WidgetConvertible {
    
    func mapToWidget() throws -> Widget {
        let widgets = try self.tabItems.compactMap {
            try ($0.content as? WidgetConvertibleEntity)?.mapToWidget()
        }
        
        guard let tabItems = widgets as? [TabItem] else {
            throw WidgetConvertibleError.invalidType
        }
        
        return TabView(tabItems: tabItems)
    }
}

struct TabItemEntity: WidgetEntity {
    let icon: String?
    let title: String?
    let content: AnyDecodableContainer?
}

extension TabItemEntity: WidgetConvertible {
    func mapToWidget() throws -> Widget {
        let content = self.content?.content as? WidgetConvertibleEntity
        
        guard let widget = try content?.mapToWidget() else {
            throw WidgetConvertibleError.invalidType
        }

        return TabItem(icon: icon, title: title, content: widget)
    }
}
