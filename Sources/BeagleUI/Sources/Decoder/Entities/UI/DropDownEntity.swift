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
    
    let header: WidgetConvertibleEntity
    let child: WidgetConvertibleEntity
    
    private let headerContainer: WidgetEntityContainer
    private let childContainer: WidgetEntityContainer
    
    private enum CodingKeys: String, CodingKey {
        case headerContainer = "header"
        case childContainer = "child"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        try self.init(
            headerContainer: container.decode(WidgetEntityContainer.self, forKey: .headerContainer),
            childContainer: container.decode(WidgetEntityContainer.self, forKey: .childContainer)
        )
    }
    
    init(
        headerContainer: WidgetEntityContainer,
        childContainer: WidgetEntityContainer
    ) throws {
        
        self.headerContainer = headerContainer
        guard let headerContainerValue = headerContainer.content else {
            let entityType = String(describing: ContainerEntity.self)
            let key = CodingKeys.headerContainer.rawValue
            throw WidgetDecodingError.couldNotDecodeContentForEntityOnKey(entityType, key)
        }
        header = headerContainerValue
        
        self.childContainer = childContainer
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
        let header = try self.header.mapToWidget()
        let child = try self.child.mapToWidget()
        return DropDown(header: header, child: child)
    }
}
