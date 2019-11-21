//
//  NavigationBarEntity.swift
//  BeagleUI
//
//  Created by Gabriela Coelho on 18/11/19.
//  Copyright © 2019 Zup IT. All rights reserved.
//

import Foundation

/// Defines an API representation for `NavigationBar`
struct NavigationBarEntity: WidgetEntity {
    let title: String
    let leading: WidgetConvertibleEntity?
    let trailing: WidgetConvertibleEntity?

    private let leadingWidget: WidgetEntityContainer?
    private let trailingWidget: WidgetEntityContainer?

    private enum CodingKeys: String, CodingKey {
        case title
        case leadingWidget = "leading"
        case trailingWidget = "trailing"
    }
    
    init(
        title: String?,
        leadingWidget: WidgetEntityContainer?,
        trailingWidget: WidgetEntityContainer?
    ) throws {
        self.title = title ?? "Title"
        self.trailingWidget = trailingWidget
        guard let trailingWidgetValue = trailingWidget?.content else {
            let entityType = String(describing: NavigationBarEntity.self)
            let key = CodingKeys.trailingWidget.rawValue
            throw WidgetDecodingError.couldNotDecodeContentForEntityOnKey(entityType, key)

        }
        trailing = trailingWidgetValue
        self.leadingWidget = leadingWidget
        guard let leadingWidgetValue = leadingWidget?.content else {
            let entityType = String(describing: NavigationBarEntity.self)
            let key = CodingKeys.leadingWidget.rawValue
            throw WidgetDecodingError.couldNotDecodeContentForEntityOnKey(entityType, key)
        }
        leading = leadingWidgetValue
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        try self.init(
            title: container.decode(String.self, forKey: .title),
            leadingWidget: container.decodeIfPresent(WidgetEntityContainer.self, forKey: .leadingWidget),
            trailingWidget: container.decodeIfPresent(WidgetEntityContainer.self, forKey: .trailingWidget)
        )
    }

}

extension NavigationBarEntity: WidgetConvertible {
    func mapToWidget() throws -> Widget {
        
        let leading = try self.leading?.mapToWidget()
        let trailing = try self.trailing?.mapToWidget()
        
        return NavigationBar(title: title,
                             leading: leading,
                             trailing: trailing)
    }
}
