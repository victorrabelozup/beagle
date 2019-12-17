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

public typealias RendererDependencies =
    DependencyFlexViewConfigurator
    & DependencyRendererProvider
    & DependencyTheme
    & DependencyValidatorProvider

public protocol WidgetViewRendererProtocol {
    init(
        widget: Widget,
        dependencies: RendererDependencies?
    ) throws

    func buildView(context: BeagleContext) -> UIView
}

@dynamicMemberLookup
open class WidgetViewRenderer<W: Widget>: WidgetViewRendererProtocol {

    var dependencies: RendererDependencies

    private(set) public var widget: W
    
    required public init(
        widget: Widget,
        dependencies: RendererDependencies? = nil
    ) throws {
        self.widget = try .newByCasting(widget: widget, to: W.self)
        self.dependencies = dependencies ?? Beagle.dependencies
    }
    
    open func buildView(context: BeagleContext) -> UIView {
        fatalError("This needs to be overriden.")
    }

    subscript<T>(dynamicMember keyPath: KeyPath<RendererDependencies, T>) -> T {
        return dependencies[keyPath: keyPath]
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
