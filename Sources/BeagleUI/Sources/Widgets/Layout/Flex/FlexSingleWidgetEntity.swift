//
//  FlexSingleWidgetEntity.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 02/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

struct FlexSingleWidgetEntity: WidgetConvertibleEntity {
    
    let child: AnyDecodableContainer
    var flex: FlexEntity?
    var appearance: AppearanceEntity?

    init(
        child: AnyDecodableContainer,
        flex: FlexEntity = FlexEntity(),
        appearance: AppearanceEntity? = nil
    ) {
        self.child = child
        self.flex = flex
        self.appearance = appearance
    }
    
    func mapToWidget() throws -> Widget {
        let widgetEntity = self.child.content as? WidgetConvertibleEntity
        let child = try widgetEntity?.mapToWidget() ?? AnyWidget(value: self.child.content)
        let flex = try self.flex?.mapToUIModel() ?? Flex()
        let appearance = try self.appearance?.mapToUIModel()
        
        return FlexSingleWidget(
            child: child,
            flex: flex,
            appearance: appearance
        )
    }
}
