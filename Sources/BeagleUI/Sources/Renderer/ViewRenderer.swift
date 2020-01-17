//
//  Copyright © 04/10/19 Zup IT. All rights reserved.
//

import UIKit

public protocol ViewRenderer {

    typealias Dependencies =
        DependencyFlexViewConfigurator
        & DependencyRendererProvider
        & DependencyTheme
        & DependencyValidatorProvider
        & DependencyAppBundle

    typealias Error = ViewRendererError

    init(
        widget: Widget,
        dependencies: Dependencies
    ) throws

    func buildView(context: BeagleContext) -> UIView
}

public enum ViewRendererError: Error {

    case couldNotCastWidgetToType(String)

    public var localizedDescription: String {
        switch self {
        case let .couldNotCastWidgetToType(type):
            return "Could not cast widget to `\(type)`."
        }
    }
}

// MARK: - Implementation

open class ViewRendering<W: Widget>: ViewRenderer {

    var dependencies: Dependencies

    private(set) public var widget: W
    
    required public init(
        widget: Widget,
        dependencies: Dependencies
    ) throws {
        self.widget = try .newByCasting(widget: widget, to: W.self)
        self.dependencies = dependencies
    }
    
    open func buildView(context: BeagleContext) -> UIView {
        fatalError("This needs to be overriden.")
    }
}

extension Widget {
    static func newByCasting<T: Widget>(widget: Widget, to: T.Type) throws -> T {
        guard let castedWidget = widget as? T else {
            let widgetType = String(describing: widget)
            throw ViewRendererError.couldNotCastWidgetToType(widgetType)
        }
        return castedWidget
    }
}
