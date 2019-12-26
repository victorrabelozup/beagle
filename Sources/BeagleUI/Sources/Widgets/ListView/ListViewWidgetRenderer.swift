//
//  ListViewWidgetRenderer.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 07/11/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import UIKit

final class ListViewWidgetRenderer: ViewRendering<ListView> {
    
    // MARK: - Public Functions
    
    override func buildView(context: BeagleContext) -> UIView {
        
        let widgetViews = widget.rows?
            .compactMap {
                self.rendererProvider
                    .buildRenderer(for: $0, dependencies: dependencies)
                    .buildView(context: context)
            } ?? []
    
        let model = ListViewUIComponent.Model(
            widget: widget,
            widgetViews: widgetViews
        )
        
        let listView = ListViewUIComponent(flexViewConfigurator: dependencies.flex, model: model)
        
        let flex = Flex(grow: 1)
        self.flex.setupFlex(flex, for: listView)
        
        self.flex.enableYoga(true, for: listView)
        
        return listView
        
    }
    
}
