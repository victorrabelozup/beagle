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
    
    let header: WidgetConvertibleEntity?
    let content: WidgetConvertibleEntity
    let footer: WidgetConvertibleEntity?
    
    private let headerContainer: WidgetEntityContainer?
    private let contentContainer: WidgetEntityContainer
    private let footerContainer: WidgetEntityContainer?
    
    private enum CodingKeys: String, CodingKey {
        case headerContainer = "header"
        case contentContainer = "content"
        case footerContainer = "footer"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        try self.init(
            headerContainer: container.decodeIfPresent(WidgetEntityContainer.self, forKey: .headerContainer),
            contentContainer: container.decode(WidgetEntityContainer.self, forKey: .contentContainer),
            footerContainer: container.decodeIfPresent(WidgetEntityContainer.self, forKey: .footerContainer)
        )
    }

    init(
        headerContainer: WidgetEntityContainer?,
        contentContainer: WidgetEntityContainer,
        footerContainer: WidgetEntityContainer?
    ) throws {
        self.headerContainer = headerContainer
        header = headerContainer?.content
        self.contentContainer = contentContainer
        guard let contentContainerValue = contentContainer.content else {
            let entityType = String(describing: ContainerEntity.self)
            let key = CodingKeys.contentContainer.rawValue
            throw WidgetDecodingError.couldNotDecodeContentForEntityOnKey(entityType, key)
        }
        content = contentContainerValue
        self.footerContainer = footerContainer
        footer = footerContainer?.content
    }
    
}
extension ContainerEntity: WidgetConvertible {

    func mapToWidget() throws -> Widget {

        let header = try self.header?.mapToWidget()
        let content = try self.content.mapToWidget()
        let footer = try self.footer?.mapToWidget()

        return Container(
            header: header,
            content: content,
            footer: footer
        )

    }

}
