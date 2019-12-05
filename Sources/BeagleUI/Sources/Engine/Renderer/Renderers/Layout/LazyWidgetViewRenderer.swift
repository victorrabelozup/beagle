//
//  LazyWidgetViewRenderer.swift
//  BeagleUI
//
//  Created by Lucas Araújo on 28/11/19.
//  Copyright © 2019 Zup IT. All rights reserved.
//

import UIKit

final class LazyWidgetViewRenderer: WidgetViewRenderer<LazyWidget> {
    
    private var context: BeagleContext?
    
    // MARK: - Public Functions
    
    override func buildView(context: BeagleContext) -> UIView {
        let initialState = widget.initialState
        let renderer = rendererProvider.buildRenderer(for: initialState)
        let initialStateView = renderer.buildView(context: context)
        context.lazyLoad(url: widget.url, initialState: initialStateView)
        return initialStateView
    }
    
}
