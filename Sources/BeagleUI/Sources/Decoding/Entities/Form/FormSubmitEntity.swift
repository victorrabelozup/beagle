//
//  FormSubmitEntity.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 11/11/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

/// Defines an API representation for `FormSubmit`
struct FormSubmitEntity: WidgetEntity {
    
    let child: WidgetConvertibleEntity
    
    private let childContainer: WidgetEntityContainer
    
    private enum CodingKeys: String, CodingKey {
        case childContainer = "child"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        try self.init(
            childContainer: container.decode(WidgetEntityContainer.self, forKey: .childContainer)
        )
    }
    
    init(
        childContainer: WidgetEntityContainer
    ) throws {
        self.childContainer = childContainer
        guard let childContainerValue = childContainer.content else {
            let entityType = String(describing: FlexSingleWidgetEntity.self)
            let key = CodingKeys.childContainer.rawValue
            throw WidgetDecodingError.couldNotDecodeContentForEntityOnKey(entityType, key)
        }
        child = childContainerValue
    }
    
}
extension FormSubmitEntity: WidgetConvertible {
    
    func mapToWidget() throws -> Widget {
        let child = try self.child.mapToWidget()
        return FormSubmit(child: child)
    }
    
}
