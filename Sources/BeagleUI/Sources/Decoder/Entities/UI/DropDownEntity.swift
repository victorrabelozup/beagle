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
    let header: WidgetEntityContainer
    let child: WidgetEntityContainer
}
extension DropDownEntity: WidgetConvertible {
    func mapToWidget() throws -> Widget {
        
        guard let headerContent = header.content else {
            throw WidgetConvertibleError.emptyContentForContainerOfType(header.type)
        }
        
        guard let childContent = child.content else {
            throw WidgetConvertibleError.emptyContentForContainerOfType(child.type)
        }
        
        let header = try headerContent.mapToWidget()
        let child = try childContent.mapToWidget()
        
        return DropDown(header: header, child: child)
    }
}
