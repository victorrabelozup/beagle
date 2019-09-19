//
//  ContainerEntity.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 18/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

/// Defines an API representation for `Container`
struct ContainerEntity: WidgetEntity {
    let body: WidgetEntityContainer?
    let content: WidgetEntityContainer
    let footer: WidgetEntityContainer?
}
extension ContainerEntity: WidgetConvertible {
    
    func mapToWidget() throws -> Widget {
        
        guard let contentContainerValue = self.content.content else {
            let type = self.content.type
            throw WidgetConvertibleError.emptyContentForContainerOfType(type)
        }
        
        let body = try self.body?.content?.mapToWidget()
        let content = try contentContainerValue.mapToWidget()
        let footer = try self.footer?.content?.mapToWidget()
        
        return Container(
            body: body,
            content: content,
            footer: footer
        )
        
    }
    
}
