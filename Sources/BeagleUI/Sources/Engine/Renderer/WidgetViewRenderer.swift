//
//  WidgetViewRenderer.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 04/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import UIKit

public enum WidgetViewRenderingError: Error {
    
    case couldNotCastWidgetToType(String)
    
    public var localizedDescription: String {
        switch self {
        case let .couldNotCastWidgetToType(type):
            return "Could not cast widget to `\(type)`."
        }
    }
    
}

public protocol WidgetViewRendererProtocol {
    init(_ widget: Widget) throws
    func buildView() -> UIView
}

public class WidgetViewRenderer<W: Widget>: WidgetViewRendererProtocol {
    
    let screenSizeProvider: ScreenSizeProvider
    let flexViewConfigurator: FlexViewConfiguratorProtocol
    let rendererProvider: WidgetRendererProvider
    private(set) var widget: W
    
    required public convenience init(_ widget: Widget) throws {
        try self.init(widget: widget)
    }
    
    init(
        widget: Widget,
        screenSizeProvider: ScreenSizeProvider = UIScreen.main,
        rendererProvider: WidgetRendererProvider = WidgetRendererProviding(),
        flexViewConfigurator: FlexViewConfiguratorProtocol = FlexViewConfigurator()
    ) throws {
        self.widget = try .newByCasting(widget: widget, to: W.self)
        self.screenSizeProvider = screenSizeProvider
        self.rendererProvider = rendererProvider
        self.flexViewConfigurator = flexViewConfigurator
    }
    
    open func buildView() -> UIView {
        fatalError("This needs to be overriden.")
    }
    
}

extension Widget {
    static func newByCasting<T: Widget>(widget: Widget, to: T.Type) throws -> T {
        guard let castedWidget = widget as? T else {
            let widgetType = String(describing: widget)
            throw WidgetViewRenderingError.couldNotCastWidgetToType(widgetType)
        }
        return castedWidget
    }
}
