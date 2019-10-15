//
//  WidgetRendererProviderRegister.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 14/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

enum CustomWidgetsRendererProviderRegisterError: Error {
    
    case couldNotFindRendererForWidgetOfType(String)
    
    var localizedDescription: String {
        switch self {
        case let .couldNotFindRendererForWidgetOfType(typeName):
            return "Could not find renderer for Widget of type \(typeName)."
        }
    }
    
}

protocol CustomWidgetsRendererProviderRegistering {
    func registerRenderer<R: WidgetViewRenderer, W: Widget>(_ rendererType: R.Type, for widgetType: W.Type)
}

protocol CustomWidgetsRendererProviderDequeuing {
    func dequeueRenderer(for widget: Widget) throws -> WidgetViewRenderer
}

final class CustomWidgetsRendererProviderRegister: CustomWidgetsRendererProviderRegistering, CustomWidgetsRendererProviderDequeuing {
    
    // MARK: - Private Properties
    
    private var renderers = [String: WidgetViewRenderer.Type]()
    
    // MARK: - Public Functions
    
    func registerRenderer<R: WidgetViewRenderer, W: Widget>(_ rendererType: R.Type, for widgetType: W.Type) {
        let widgetTypeName = String(describing: widgetType)
        renderers[widgetTypeName] = rendererType
    }
    
    func dequeueRenderer(for widget: Widget) throws -> WidgetViewRenderer {
        let widgetTypeName = String(describing: type(of: widget))
        guard let rendererType = renderers[widgetTypeName] else {
            throw CustomWidgetsRendererProviderRegisterError.couldNotFindRendererForWidgetOfType(widgetTypeName)
        }
        return try rendererType.init(widget)
    }
    
}
