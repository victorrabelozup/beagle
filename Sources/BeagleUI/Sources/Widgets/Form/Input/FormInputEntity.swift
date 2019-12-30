//
//  FormInputEntity.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 11/11/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

struct FormInputEntity: WidgetConvertibleEntity {
    
    let name: String
    let required: Bool?
    let validator: String?
    let errorMessage: String?
    let child: AnyDecodableContainer
    
    func mapToWidget() throws -> Widget {
        let widgetEntity = self.child.content as? WidgetConvertibleEntity
        let child = try widgetEntity?.mapToWidget() ?? AnyWidget(value: self.child.content)
        return FormInput(
            name: name,
            required: required,
            validator: validator,
            errorMessage: errorMessage,
            child: child
        )
    }
}
