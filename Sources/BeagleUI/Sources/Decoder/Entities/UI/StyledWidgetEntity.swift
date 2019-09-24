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
    let child: WidgetEntity?
    
    private let childContainer: WidgetEntityContainer?
    
    enum CodingKeys: String, CodingKey {
        case border
        case color
        case childContainer = "child"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        border = try container.decodeIfPresent(BorderEntity.self, forKey: .border)
        color = try container.decodeIfPresent(String.self, forKey: .color)
        childContainer = try container.decodeIfPresent(WidgetEntityContainer.self, forKey: .childContainer)
        child = childContainer?.content
    }
    
    init(
        border: BorderEntity?,
        color: String?,
        childContainer: WidgetEntityContainer?
    ) {
        self.border = border
        self.color = color
        self.childContainer = childContainer
        self.child = childContainer?.content
    }
    
}
extension StyledWidgetEntity: WidgetConvertible {
    func mapToWidget() throws -> Widget {
        var uiBorder: Border?
        if let border = border {
            uiBorder = Border(color: border.color, radius: border.radius, size: border.size)
        }
        let child = try? self.childContainer?.content?.mapToWidget()
        return StyledWidget(border: uiBorder, color: color, child: child)
    }
}

/// Defines an API representation for `Border`
struct BorderEntity: WidgetEntity {
    let color: String?
    let radius: Double?
    let size: Double?
}
