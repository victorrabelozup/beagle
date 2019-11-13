//
//  ListViewWidgetRenderer.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 07/11/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import UIKit

final class ListViewWidgetRenderer: WidgetViewRenderer<ListView> {
    
    // MARK: - Public Functions
    
    override func buildView(context: BeagleContext) -> UIView {
        
        let widgetViews = widget.rows?
            .compactMap {
                rendererProvider
                    .buildRenderer(for: $0)
                    .buildView(context: context)
            } ?? []
    
        let model = ListViewUIComponent.Model(
            widget: widget,
            widgetViews: widgetViews
        )
        
        let listView = ListViewUIComponent(model: model)
        
        let flex = Flex(grow: 1)
        flexViewConfigurator.setupFlex(flex, for: listView)
        
        flexViewConfigurator.enableYoga(true, for: listView)
        
        return listView
        
    }
    
}
