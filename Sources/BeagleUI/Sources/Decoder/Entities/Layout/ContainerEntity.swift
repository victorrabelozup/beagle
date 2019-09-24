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
    
    let body: WidgetEntity?
    let content: WidgetEntity
    let footer: WidgetEntity?
    
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
        bodyContainer = try container.decode(WidgetEntityContainer.self, forKey: .bodyContainer)
        body = bodyContainer?.content
        contentContainer = try container.decode(WidgetEntityContainer.self, forKey: .contentContainer)
        guard let contentContainerValue = contentContainer.content else {
            let entityType = String(describing: ContainerEntity.self)
            let key = CodingKeys.contentContainer.rawValue
            throw WidgetDecodingError.couldNotDecodeContentForEntityOnKey(entityType, key)
        }
        content = contentContainerValue
        footerContainer = try container.decode(WidgetEntityContainer.self, forKey: .footerContainer)
        footer = footerContainer?.content
    }
    
//    init(
//        body: WidgetEntity?,
//        content: WidgetEntity,
//        footer: WidgetEntity?
//    ) {
//        self.body = body
//        self.content = content
//        self.footer = footer
//    }
    
}
extension ContainerEntity: WidgetConvertible {

    func mapToWidget() throws -> Widget {

        guard let contentContainerValue = self.contentContainer.content else {
            let type = self.contentContainer.type
            throw WidgetConvertibleError.emptyContentForContainerOfType(type)
        }

        let body = try self.bodyContainer?.content?.mapToWidget()
        let content = try contentContainerValue.mapToWidget()
        let footer = try self.footerContainer?.content?.mapToWidget()

        return Container(
            body: body,
            content: content,
            footer: footer
        )

    }

}
