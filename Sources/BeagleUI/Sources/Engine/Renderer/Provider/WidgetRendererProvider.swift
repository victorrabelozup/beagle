//
//  WidgetRendererProvider.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 07/10/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

public protocol WidgetRendererProvider {

    func buildRenderer(for widget: Widget, dependencies: RendererDependencies) -> WidgetViewRendererProtocol
}

public protocol WidgetRendererProviderThrowable {

    func buildRenderer(for widget: Widget, dependencies: RendererDependencies) throws -> WidgetViewRendererProtocol
}

final class WidgetRendererProviding: WidgetRendererProvider {

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

    public lazy var providers: [WidgetRendererProviderThrowable] = [
        LayoutViewRendererProviding(),
        UIComponentViewRendererProviding(),
        Beagle.environment.shared.customWidgetsProvider
    ]
    
    // MARK: - Public Methods
    
    func buildRenderer(for widget: Widget, dependencies: RendererDependencies) -> WidgetViewRendererProtocol {
        var result: WidgetViewRendererProtocol = UnknownWidgetViewRenderer(widget: widget)

        for provider in providers {
            if let render = try? provider.buildRenderer(for: widget, dependencies: dependencies) {
                result = render
                break
            }
        }

        return result
    }
}
