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
    func registerRenderer<W: Widget>(_ rendererType: WidgetViewRenderer<W>.Type, for widgetType: W.Type)
}

public protocol CustomWidgetsRendererProviderDequeuing {
    func dequeueRenderer(for widget: Widget) throws -> WidgetViewRendererProtocol
}

final class CustomWidgetsRendererProviderRegister: CustomWidgetsRendererProviderRegistering, CustomWidgetsRendererProviderDequeuing {
    
    // MARK: - Private Properties
    
    private var renderers = [String: WidgetViewRendererProtocol.Type]()
    
    // MARK: - Public Functions
    
    func registerRenderer<W: Widget>(_ rendererType: WidgetViewRenderer<W>.Type, for widgetType: W.Type) {
        let widgetTypeName = String(describing: widgetType)
        renderers[widgetTypeName] = rendererType
    }
    
    public func dequeueRenderer(for widget: Widget) throws -> WidgetViewRendererProtocol {
        let widgetTypeName = String(describing: type(of: widget))
        guard let rendererType = renderers[widgetTypeName] else {
            throw CustomWidgetsRendererProviderRegisterError.couldNotFindRendererForWidgetOfType(widgetTypeName)
        }
        return try rendererType.init(widget)
    }
    
}
