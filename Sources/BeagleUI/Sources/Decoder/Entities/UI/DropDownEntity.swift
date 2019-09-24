//
//  DropDownEntity.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 18/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

/// Defines an API representation for `DropDown`
struct DropDownEntity: WidgetEntity {
    
    let header: WidgetEntity
    let child: WidgetEntity
    
    let headerContainer: WidgetEntityContainer
    let childContainer: WidgetEntityContainer
    
    enum CodingKeys: String, CodingKey {
        case headerContainer = "header"
        case childContainer = "content"
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        headerContainer = try container.decode(WidgetEntityContainer.self, forKey: .headerContainer)
        guard let headerContainerValue = headerContainer.content else {
            let entityType = String(describing: ContainerEntity.self)
            let key = CodingKeys.headerContainer.rawValue
            throw WidgetDecodingError.couldNotDecodeContentForEntityOnKey(entityType, key)
        }
        header = headerContainerValue
        
        childContainer = try container.decode(WidgetEntityContainer.self, forKey: .childContainer)
        guard let childContainerValue = childContainer.content else {
            let entityType = String(describing: ContainerEntity.self)
            let key = CodingKeys.childContainer.rawValue
            throw WidgetDecodingError.couldNotDecodeContentForEntityOnKey(entityType, key)
        }
        child = childContainerValue
        
    }
    
}
extension DropDownEntity: WidgetConvertible {
    func mapToWidget() throws -> Widget {
        
        guard let headerContent = headerContainer.content else {
            throw WidgetConvertibleError.emptyContentForContainerOfType(headerContainer.type)
        }
        
        guard let childContent = childContainer.content else {
            throw WidgetConvertibleError.emptyContentForContainerOfType(childContainer.type)
        }
        
        let header = try headerContent.mapToWidget()
        let child = try childContent.mapToWidget()
        
        return DropDown(header: header, child: child)
    }
}
