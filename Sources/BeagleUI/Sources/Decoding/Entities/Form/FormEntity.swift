//
//  FormEntity.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 11/11/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

/// Defines an API representation for `Form`
struct FormEntity: WidgetEntity {
    
    let action: String
    let method: MethodType
    let child: WidgetConvertibleEntity
    
    private let childContainer: WidgetEntityContainer
    
    private enum CodingKeys: String, CodingKey {
        case action
        case method
        case childContainer = "child"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        try self.init(
            action: container.decode(String.self, forKey: .action),
            method: container.decode(MethodType.self, forKey: .method),
            childContainer: container.decode(WidgetEntityContainer.self, forKey: .childContainer)
        )
    }
    
    init(
        action: String,
        method: MethodType,
        childContainer: WidgetEntityContainer
    ) throws {
        self.action = action
        self.method = method
        self.childContainer = childContainer
        guard let childContainerValue = childContainer.content else {
            let entityType = String(describing: FlexSingleWidgetEntity.self)
            let key = CodingKeys.childContainer.rawValue
            throw WidgetDecodingError.couldNotDecodeContentForEntityOnKey(entityType, key)
        }
        child = childContainerValue
    }
    
}
extension FormEntity: WidgetConvertible {
    
    func mapToWidget() throws -> Widget {
        let child = try self.child.mapToWidget()
        let method = try self.method.mapToUIModel(ofType: Form.MethodType.self)
        return Form(
            action: action,
            method: method,
            child: child
        )
    }
    
}

extension FormEntity {
    enum MethodType: String, WidgetEntity, UIEnumModelConvertible {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }
}
