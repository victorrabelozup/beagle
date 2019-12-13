//
//  WidgetRendererProviderRegister.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 14/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

public protocol CustomWidgetsRendererProvider: WidgetRendererProviderThrowable {

    func registerRenderer<W: Widget>(
        _ rendererType: WidgetViewRenderer<W>.Type,
        for widgetType: W.Type
    )
}

final class CustomWidgetsRendererProviding: CustomWidgetsRendererProvider {
    
    // MARK: - Private Properties
    
    private var renderers = [String: WidgetViewRendererProtocol.Type]()
    
    // MARK: - Public Functions
    
    func registerRenderer<W: Widget>(
        _ rendererType: WidgetViewRenderer<W>.Type,
        for widgetType: W.Type
    ) {
        let widgetTypeName = String(describing: widgetType)
        renderers[widgetTypeName] = rendererType
    }
    
    public func buildRenderer(for widget: Widget, dependencies: RendererDependencies) throws -> WidgetViewRendererProtocol {
        let name = String(describing: type(of: widget))
        guard let rendererType = renderers[name] else {
            throw WidgetRendererProviding.Error.couldNotFindRendererForWidget(widget)
        }
        return try rendererType.init(widget: widget, dependencies: dependencies)
    }
    
}
