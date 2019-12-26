//
//  FormInputEntity.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 11/11/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

struct FormInputEntity: WidgetConvertibleEntity {
    
    let name: String
    var required: Bool?
    var validator: String?
    let child: AnyDecodableContainer
    
    func mapToWidget() throws -> Widget {
        let widgetEntity = self.child.content as? WidgetConvertibleEntity
        let child = try widgetEntity?.mapToWidget() ?? AnyWidget(value: self.child.content)
        return FormInput(
            name: name,
            required: required,
            validator: validator,
            child: child
        )
    }
}
