//
//  LazyComponentEntity.swift
//  BeagleUI
//
//  Created by Lucas Araújo on 27/11/19.
//  Copyright © 2019 Zup IT. All rights reserved.
//

struct LazyComponentEntity: ComponentConvertibleEntity {
    
    let url: String
    let initialState: AnyDecodableContainer

    func mapToComponent() throws -> ServerDrivenComponent {
        let initialStateEntity = initialState.content as? ComponentConvertibleEntity
        let initialComponent = try initialStateEntity?.mapToComponent() ?? AnyComponent(value: initialState.content)
        return LazyComponent(url: url, initialState: initialComponent)
    }
}
