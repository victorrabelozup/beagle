//
//  FormSubmitEntity.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 11/11/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

struct FormSubmitEntity: ComponentConvertibleEntity {
    
    let child: AnyDecodableContainer
    let enabled: Bool?
    
    func mapToComponent() throws -> ServerDrivenComponent {
        let componentEntity = self.child.content as? ComponentConvertibleEntity
        let child = try componentEntity?.mapToComponent() ?? AnyComponent(value: self.child.content)
        return FormSubmit(child: child, enabled: enabled)
    }
}
