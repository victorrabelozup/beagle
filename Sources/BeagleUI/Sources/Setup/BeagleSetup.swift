//
//  Copyright © 14/10/19 Daniel Tes. All rights reserved.
//

import Foundation

public class Beagle {

    public static var dependencies: BeagleDependenciesProtocol = BeagleDependencies()

    private init() {}

    // MARK: - Public Functions
    
    /// Register a custom widget
    public static func registerCustomWidget<W: Widget, E: WidgetConvertibleEntity, R: ViewRendering<W>>(
        _ name: String,
        widgetType: W.Type,
        entityType: E.Type,
        rendererType: R.Type
    ) {
        let entityPair = WidgetRegisterItem<E, W>.EntityPair(typeName: name, type: entityType)
        let viewPair = ViewPair(widgetType: widgetType, viewRenderer: rendererType)
        let item = WidgetRegisterItem(entity: entityPair, view: viewPair)
        
        dependencies.decoder.register(item.entity.type, for: item.entity.typeName)
        dependencies.customWidgetsProvider.registerRenderer(
            item.view.viewRenderer, for: item.view.widgetType
        )
    }
}
