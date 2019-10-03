//
//  FlexSingleWidgetEntity.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 02/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

/// Defines an API representation for `FlexWidget`
struct FlexSingleWidgetEntity: WidgetEntity {
    
    let child: WidgetConvertibleEntity
    let flex: FlexEntity
    
    private let childContainer: WidgetEntityContainer
    
    private enum CodingKeys: String, CodingKey {
        case childContainer = "child"
        case flex
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        try self.init(
            childContainer: container.decode(WidgetEntityContainer.self, forKey: .childContainer),
            flex: container.decodeIfPresent(FlexEntity.self, forKey: .flex)
        )
    }
    
    init(
        childContainer: WidgetEntityContainer,
        flex: FlexEntity?
    ) throws {
        self.childContainer = childContainer
        guard let childContainerValue = childContainer.content else {
            let entityType = String(describing: FlexSingleWidgetEntity.self)
            let key = CodingKeys.childContainer.rawValue
            throw WidgetDecodingError.couldNotDecodeContentForEntityOnKey(entityType, key)
        }
        child = childContainerValue
        self.flex = flex ?? FlexEntity()
    }
    
}
extension FlexSingleWidgetEntity: WidgetConvertible, ChildrenWidgetMapping {

    func mapToWidget() throws -> Widget {
        
        let child = try self.child.mapToWidget()
        let flex = try self.flex.mapToUIModel()

        return FlexSingleWidget(
            child: child,
            flex: flex
        )
        
    }

}
