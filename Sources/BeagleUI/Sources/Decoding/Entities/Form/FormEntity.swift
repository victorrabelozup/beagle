//
//  FormEntity.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 11/11/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

struct FormEntity: WidgetConvertibleEntity {
    
    let action: String
    let method: MethodType
    let child: AnyDecodableContainer
    
    func mapToWidget() throws -> Widget {
        let widgetEntity = self.child.content as? WidgetConvertibleEntity
        let child = try widgetEntity?.mapToWidget() ?? AnyWidget(value: self.child.content)
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
