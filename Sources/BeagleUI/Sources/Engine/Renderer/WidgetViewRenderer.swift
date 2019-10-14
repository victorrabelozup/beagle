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
    init(_ widget: Widget) throws
    func buildView() -> UIView
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
