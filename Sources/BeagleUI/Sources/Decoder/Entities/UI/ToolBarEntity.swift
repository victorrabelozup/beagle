//
//  ToolBarEntity.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 18/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

/// Defines an API representation for `ToolBar`
struct ToolBarEntity: WidgetEntity {
    
    let title: String
    let showBackButton: Bool
    
    private enum CodingKeys: String, CodingKey {
        case title
        case showBackButton
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        try self.init(
            title: container.decode(String.self, forKey: .title),
            showBackButton: container.decodeIfPresent(Bool.self, forKey: .showBackButton)
        )
    }
    
    init(
        title: String,
        showBackButton: Bool?
    ) {
        self.title = title
        self.showBackButton = showBackButton ?? true
    }
    
}
extension ToolBarEntity: WidgetConvertible {
    func mapToWidget() throws -> Widget {
        return ToolBar(title: title, showBackButton: showBackButton)
    }
}
