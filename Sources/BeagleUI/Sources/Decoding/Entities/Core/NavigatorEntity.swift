//
//  NavigatorEntity.swift
//  BeagleUI
//
//  Created by Lucas Araújo on 04/11/19.
//  Copyright © 2019 Zup IT. All rights reserved.
//

import Foundation

/// Defines an API representation for `Navigator`
struct NavigatorEntity: WidgetConvertibleEntity {
    
    let action: NavigateEntity
    let child: WidgetConvertibleEntity
    
    private let childContainer: WidgetEntityContainer
    
    private enum CodingKeys: String, CodingKey {
        case action
        case childContainer = "child"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        try self.init(
            action: container.decode(NavigateEntity.self, forKey: .action),
            childContainer: container.decode(WidgetEntityContainer.self, forKey: .childContainer)
        )
    }
    
    init(
        action: NavigateEntity,
        childContainer: WidgetEntityContainer
    ) throws {
        self.action = action
        self.childContainer = childContainer
        guard let childContainerValue = childContainer.content else {
            let entityType = String(describing: NavigatorEntity.self)
            let key = CodingKeys.childContainer.rawValue
            throw WidgetDecodingError.couldNotDecodeContentForEntityOnKey(entityType, key)
        }
        child = childContainerValue
    }
    
    func mapToWidget() throws -> Widget {
        return Navigator(
            action: try action.mapToUIModel(),
            child: try child.mapToWidget()
        )
    }
}
