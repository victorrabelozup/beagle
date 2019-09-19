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
    let showBackButton: Bool = true
}
extension ToolBarEntity: WidgetConvertible {
    func mapToWidget() throws -> Widget {
        return ToolBar(title: title, showBackButton: showBackButton)
    }
}
