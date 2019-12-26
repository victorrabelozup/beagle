//
//  WidgetRendererProviderRegister.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 14/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

public protocol CustomWidgetsRendererProvider: RendererProviderThrowable {

    func registerRenderer<W: Widget>(
        _ rendererType: ViewRendering<W>.Type,
        for widgetType: W.Type
    )
}

final class CustomWidgetsRendererProviding: CustomWidgetsRendererProvider {
    
    // MARK: - Private Properties
    
    private var renderers = [String: ViewRenderer.Type]()
    
    // MARK: - Public Functions
    
    func registerRenderer<W: Widget>(
        _ rendererType: ViewRendering<W>.Type,
        for widgetType: W.Type
    ) {
        let widgetTypeName = String(describing: widgetType)
        renderers[widgetTypeName] = rendererType
    }
    
    public func buildRenderer(
        for widget: Widget,
        dependencies: ViewRenderer.Dependencies
    ) throws -> ViewRenderer {
        let name = String(describing: type(of: widget))
        guard let rendererType = renderers[name] else {
            throw RendererProviding.Error.couldNotFindRendererForWidget(widget)
        }
        return try rendererType.init(widget: widget, dependencies: dependencies)
    }
    
}
