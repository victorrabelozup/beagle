//
//  Copyright © 07/10/19 Zup IT. All rights reserved.
//

import Foundation

public protocol RendererProvider {

    func buildRenderer(
        for widget: Widget,
        dependencies: ViewRenderer.Dependencies
    ) -> ViewRenderer
}

public protocol DependencyRendererProvider {
    var rendererProvider: RendererProvider { get }
}

public protocol RendererProviderThrowable {

    func buildRenderer(
        for widget: Widget,
        dependencies: ViewRenderer.Dependencies
    ) throws -> ViewRenderer
}

// MARK: - Implementation

final class RendererProviding: RendererProvider {

    public enum Error: Swift.Error {

        case couldNotFindRendererForWidget(Widget)

        var localizedDescription: String {
            switch self {
            case .couldNotFindRendererForWidget(let widget):
                let name = String(describing: type(of: widget))
                return "\(name) has no renderer's registered, please check this."
            }
        }
    }

    // MARK: - Dependencies

    public lazy var providers: [RendererProviderThrowable] = [
        LayoutViewRendererProviding(),
        UIComponentViewRendererProviding(),
        Beagle.customWidgetsProvider
    ]
    
    // MARK: - Public Methods
    
    func buildRenderer(
        for widget: Widget,
        dependencies: ViewRenderer.Dependencies
    ) -> ViewRenderer {
        var result: ViewRenderer = UnknownWidgetViewRenderer(widget: widget)

        for provider in providers {
            if let render = try? provider.buildRenderer(for: widget, dependencies: dependencies) {
                result = render
                break
            }
        }

        return result
    }
}
