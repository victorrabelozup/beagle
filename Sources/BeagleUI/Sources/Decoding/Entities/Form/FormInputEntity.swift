//
//  FormInputEntity.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 11/11/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

/// Defines an API representation for `FormSubmit`
struct FormInputEntity: WidgetEntity {
    
    let name: String
    let required: Bool?
    let validator: String?
    let child: WidgetConvertibleEntity
    
    private let childContainer: WidgetEntityContainer
    
    private enum CodingKeys: String, CodingKey {
        case name
        case required
        case validator
        case childContainer = "child"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        try self.init(
            name: container.decode(String.self, forKey: .name),
            required: container.decodeIfPresent(Bool.self, forKey: .required),
            validator: container.decodeIfPresent(String.self, forKey: .validator),
            childContainer: container.decode(WidgetEntityContainer.self, forKey: .childContainer)
        )
    }
    
    init(
        name: String,
        required: Bool? = nil,
        validator: String? = nil,
        childContainer: WidgetEntityContainer
    ) throws {
        self.name = name
        self.required = required
        self.validator = validator
        self.childContainer = childContainer
        guard let childContainerValue = childContainer.content else {
            let entityType = String(describing: FlexSingleWidgetEntity.self)
            let key = CodingKeys.childContainer.rawValue
            throw WidgetDecodingError.couldNotDecodeContentForEntityOnKey(entityType, key)
        }
        child = childContainerValue
    }
    
}
extension FormInputEntity: WidgetConvertible {
    
    func mapToWidget() throws -> Widget {
        let child = try self.child.mapToWidget()
        return FormInput(
            name: name,
            required: required,
            validator: validator,
            child: child
        )
    }
    
}
