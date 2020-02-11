//
//  FormSubmitEntity.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 11/11/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

struct FormSubmitEntity: WidgetConvertibleEntity {
    
    let child: AnyDecodableContainer
    let enabled: Bool?
    
    func mapToWidget() throws -> Widget {
        let widgetEntity = self.child.content as? WidgetConvertibleEntity
        let child = try widgetEntity?.mapToWidget() ?? AnyWidget(value: self.child.content)
        return FormSubmit(child: child, enabled: enabled)
    }
}
