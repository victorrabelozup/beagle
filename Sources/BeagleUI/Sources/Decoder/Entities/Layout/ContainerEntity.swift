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
    
    let body: WidgetEntityContainerContent?
    let content: WidgetEntityContainerContent
    let footer: WidgetEntityContainerContent?
    
    private let bodyContainer: WidgetEntityContainer?
    private let contentContainer: WidgetEntityContainer
    private let footerContainer: WidgetEntityContainer?
    
    enum CodingKeys: String, CodingKey {
        case bodyContainer = "body"
        case contentContainer = "content"
        case footerContainer = "footer"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        try self.init(
            bodyContainer: container.decodeIfPresent(WidgetEntityContainer.self, forKey: .bodyContainer),
            contentContainer: container.decode(WidgetEntityContainer.self, forKey: .contentContainer),
            footerContainer: container.decodeIfPresent(WidgetEntityContainer.self, forKey: .footerContainer)
        )
    }

    init(
        bodyContainer: WidgetEntityContainer?,
        contentContainer: WidgetEntityContainer,
        footerContainer: WidgetEntityContainer?
    ) throws {
        self.bodyContainer = bodyContainer
        body = bodyContainer?.content
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

        let body = try self.body?.mapToWidget()
        let content = try self.content.mapToWidget()
        let footer = try self.footer?.mapToWidget()

        return Container(
            body: body,
            content: content,
            footer: footer
        )

    }

}
