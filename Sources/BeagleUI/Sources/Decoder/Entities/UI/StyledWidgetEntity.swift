//
//  StyledWidgetEntity.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 18/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

/// Defines an API representation for `StyledWidget`
struct StyledWidgetEntity: WidgetEntity {
    
    let border: BorderEntity?
    let color: String?
    let child: WidgetConvertibleEntity
    
    private let childContainer: WidgetEntityContainer?
    
    private enum CodingKeys: String, CodingKey {
        case border
        case color
        case childContainer = "child"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        try self.init(
            border: container.decodeIfPresent(BorderEntity.self, forKey: .border),
            color: container.decodeIfPresent(String.self, forKey: .color),
            childContainer: container.decode(WidgetEntityContainer.self, forKey: .childContainer)
        )
    }
    
    init(
        border: BorderEntity?,
        color: String?,
        childContainer: WidgetEntityContainer
    ) throws {
        self.border = border
        self.color = color
        self.childContainer = childContainer
        guard let childContainerValue = childContainer.content else {
            let entityType = String(describing: StyledWidgetEntity.self)
            let key = CodingKeys.childContainer.rawValue
            throw WidgetDecodingError.couldNotDecodeContentForEntityOnKey(entityType, key)
        }
        self.child = childContainerValue
    }
    
}
extension StyledWidgetEntity: WidgetConvertible {
    func mapToWidget() throws -> Widget {
        var uiBorder: Border?
        if let border = border {
            uiBorder = Border(color: border.color, radius: border.radius, size: border.size)
        }
        let child = try self.child.mapToWidget()
        return StyledWidget(border: uiBorder, color: color, child: child)
    }
}

/// Defines an API representation for `Border`
struct BorderEntity: WidgetEntity {
    let color: String?
    let radius: Double?
    let size: Double?
}
