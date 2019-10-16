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

public protocol WidgetViewRenderer {
    func buildView() -> UIView
}

public class BaseWidgetViewRenderer<W: Widget>: WidgetViewRenderer {
    
    let flexViewConfigurator: FlexViewConfiguratorProtocol
    let rendenrerProvider: WidgetRendererProvider
    private(set) var widget: W
    
    public init(
        _ widget: Widget,
        rendenrerProvider: WidgetRendererProvider? = nil,
        flexViewConfigurator: FlexViewConfiguratorProtocol? = nil
    ) throws {
        self.widget = try .newByCasting(widget: widget, to: W.self)
        self.rendenrerProvider = rendenrerProvider ?? WidgetRendererProviding()
        self.flexViewConfigurator = flexViewConfigurator ?? FlexViewConfigurator()
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
