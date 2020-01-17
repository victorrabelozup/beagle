//
//  LazyWidgetEntity.swift
//  BeagleUI
//
//  Created by Lucas Araújo on 27/11/19.
//  Copyright © 2019 Zup IT. All rights reserved.
//

struct LazyWidgetEntity: WidgetConvertibleEntity {
    
    let url: String
    let initialState: AnyDecodableContainer

    func mapToWidget() throws -> Widget {
        let initialStateEntity = initialState.content as? WidgetConvertibleEntity
        let initialWidget = try initialStateEntity?.mapToWidget() ?? AnyWidget(value: initialState.content)
        return LazyWidget(url: url, initialState: initialWidget)
    }
}
