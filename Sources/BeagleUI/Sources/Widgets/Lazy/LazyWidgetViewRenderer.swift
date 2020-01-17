//
//  LazyWidgetViewRenderer.swift
//  BeagleUI
//
//  Created by Lucas Araújo on 28/11/19.
//  Copyright © 2019 Zup IT. All rights reserved.
//

import UIKit

final class LazyWidgetViewRenderer: ViewRendering<LazyWidget> {
    
    private var context: BeagleContext?
    
    // MARK: - Public Functions
    
    override func buildView(context: BeagleContext) -> UIView {
        let view = dependencies.rendererProvider
            .buildRenderer(for: widget.initialState, dependencies: dependencies)
            .buildView(context: context)
        context.lazyLoad(url: widget.url, initialState: view)
        return view
    }
    
}
