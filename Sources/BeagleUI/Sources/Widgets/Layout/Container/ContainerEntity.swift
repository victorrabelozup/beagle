//
//  ContainerEntity.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 18/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

struct ContainerEntity: WidgetConvertibleEntity {
    
    let header: AnyDecodableContainer?
    let content: AnyDecodableContainer
    let footer: AnyDecodableContainer?
    
    func mapToWidget() throws -> Widget {
    
        let headerEntity = self.header?.content as? WidgetConvertibleEntity
        let header = try headerEntity?.mapToWidget()
        
        let contentEntity = self.content.content as? WidgetConvertibleEntity
        let content = try contentEntity?.mapToWidget() ?? AnyWidget(value: self.content.content)
        
        let footerEntity = self.footer?.content as? WidgetConvertibleEntity
        let footer = try footerEntity?.mapToWidget()

        return Container(
            header: header,
            content: content,
            footer: footer
        )
    }
}
