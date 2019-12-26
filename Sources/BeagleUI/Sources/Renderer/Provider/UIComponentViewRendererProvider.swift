//
//  UIComponentRendererProvider.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 16/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

final class UIComponentViewRendererProviding: RendererProviderThrowable {
    
    func buildRenderer(
        for widget: Widget,
        dependencies: ViewRenderer.Dependencies
    ) throws -> ViewRenderer {
        switch widget {
        case is Button:
            return try ButtonWidgetViewRenderer(widget: widget, dependencies: dependencies)
        case is Image:
            return try ImageWidgetViewRenderer(widget: widget, dependencies: dependencies)
        case is NetworkImage:
            return try NetworkImageWidgetViewRenderer(widget: widget, dependencies: dependencies)
        case is Text:
            return try TextWidgetViewRenderer(widget: widget, dependencies: dependencies)
        case is NavigationBar:
            return try NavigationBarWidgetViewRenderer(widget: widget, dependencies: dependencies)
        case is DefaultPageIndicator:
            return try DefaultPageIndicatorRenderer(widget: widget, dependencies: dependencies)
        default:
            throw RendererProviding.Error.couldNotFindRendererForWidget(widget)
        }
    }
    
}
