//
//  TabViewEntity.swift
//  BeagleUI
//
//  Created by Gabriela Coelho on 21/11/19.
//  Copyright © 2019 Zup IT. All rights reserved.
//

import Foundation

/// Defines an API representation for `TabView`
struct TabViewEntity: ComponentEntity {
    let tabItems: [TabItemEntity]
}

extension TabViewEntity: ComponentConvertible {
    
    func mapToComponent() throws -> ServerDrivenComponent {
        
        let tabItemsConverted: [TabItem] = try tabItems.map {
            let content = $0.content?.content as? ComponentConvertibleEntity
    
            guard let component = try content?.mapToComponent() else {
                throw ComponentConvertibleError.invalidType
            }
    
            return TabItem(icon: $0.icon, title: $0.title, content: component)
        }
        
        return TabView(tabItems: tabItemsConverted)
    }
}

struct TabItemEntity: Decodable {
    let icon: String?
    let title: String?
    let content: AnyDecodableContainer?
}
