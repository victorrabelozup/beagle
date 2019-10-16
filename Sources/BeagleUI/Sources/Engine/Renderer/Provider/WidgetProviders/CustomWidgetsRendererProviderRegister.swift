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
    func registerRenderer<W: Widget, R: WidgetViewRenderer>(_ rendererType: R.Type, for widgetType: W.Type)
}

public protocol CustomWidgetsRendererProviderDequeuing {
    func dequeueRenderer<T: Widget>(for widget: T) throws -> WidgetViewRenderer
}

final class CustomWidgetsRendererProviderRegister: CustomWidgetsRendererProviderRegistering, CustomWidgetsRendererProviderDequeuing {
    
    // MARK: - Private Properties
    
    private var renderers = [String: Any]()
    
    // MARK: - Public Functions
    
    func registerRenderer<W: Widget, R: WidgetViewRenderer>(_ rendererType: R.Type, for widgetType: W.Type) {
        let widgetTypeName = String(describing: widgetType)
        renderers[widgetTypeName] = rendererType
    }
    
    public func dequeueRenderer<T: Widget>(for widget: T) throws -> WidgetViewRenderer {
        let widgetTypeName = String(describing: type(of: widget))
        guard let renderer = renderers[widgetTypeName] as? WidgetViewRenderer else {
            throw CustomWidgetsRendererProviderRegisterError.couldNotFindRendererForWidgetOfType(widgetTypeName)
        }
        return renderer
    }
    
}
