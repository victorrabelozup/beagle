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
    let tabItems: [TabItemEntity]
}

extension TabViewEntity: WidgetConvertible {
    
    func mapToWidget() throws -> Widget {
        
        let tabItemsConverted: [TabItem] = try tabItems.map {
            let content = $0.content?.content as? WidgetConvertibleEntity
    
            guard let widget = try content?.mapToWidget() else {
                throw WidgetConvertibleError.invalidType
            }
    
            return TabItem(icon: $0.icon, title: $0.title, content: widget)
        }
        
        return TabView(tabItems: tabItemsConverted)
    }
}

struct TabItemEntity: Decodable {
    let icon: String?
    let title: String?
    let content: AnyDecodableContainer?
}

//extension TabItemEntity: WidgetConvertible {
//    func mapToWidget() throws -> Widget {
//        let content = self.content?.content as? WidgetConvertibleEntity
//
//        guard let widget = try content?.mapToWidget() else {
//            throw WidgetConvertibleError.invalidType
//        }
//
//        return TabItem(icon: icon, title: title, content: widget)
//    }
//}
